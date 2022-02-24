Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDDE4C310A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 17:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiBXQNO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 11:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiBXQNN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 11:13:13 -0500
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA41B0BF3;
        Thu, 24 Feb 2022 08:12:35 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 010FA803AB;
        Thu, 24 Feb 2022 11:10:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1645719060; bh=LBptnaz84kXUF48osWhg+vMhXBOFqAysTHDgWQz+/5M=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=KD0LqR8xTO6qwqQOxUaq8jxBCou8o56pHwuGsTPfCf1PMeqVJdJrfuw6dK+hbob6V
         krVa0xHr3PjYe8BslgHJPkXRhpbHuX+5/hStPhPZAieU9oORQYEoBQ1OcxqRjZvwJm
         UZ5xGi4Jp3DGoORsCAEh68xbEga1mHIsFqyHWSPwizZkvhe3dYQQXN62NQaLDAprWC
         ZmM3/XMKTqvlbyMAj1i9feTnZn6lV4zn7lBYRIiWM2VpapR0SSFVooHJZN4tXb+l0S
         YnxmD6QSbNIvYkqO0zyBeMtURlRYKF9C9zpxsjm29HMklOJNbC4aLIX3Goj9oFTBXL
         7geTeoejQh9rg==
Message-ID: <284ccc08-8de7-9188-19d8-20f4eda56cb4@dorminy.me>
Date:   Thu, 24 Feb 2022 11:10:59 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v4] btrfs: add fs state details to error messages.
Content-Language: en-US
To:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <a059920460fe13f773fd9a2e870ceb9a8e3a105a.1645644489.git.sweettea-kernel@dorminy.me>
 <20220224132210.GS12643@twin.jikos.cz>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220224132210.GS12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Added to misc-next with some minor updates, thanks.
>
Awesome, thank you. I realized this morning that it might be technically 
slightly racy actually and would propose something like the following

static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
{
	unsigned int bit;
+	unsigned long fs_state = READ_ONCE(info->fs_state);
	unsigned int states_printed = 0;
	char *curr = buf;

	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
	curr += sizeof(STATE_STRING_PREFACE) - 1;

-	for_each_set_bit(bit, &info->fs_state, sizeof(info->fs_state)) {
+	for_each_set_bit(bit, fs_state, sizeof(fs_state)) {


All the other interactions with info->fs_state are test/set/clear_bit, which treat the argument as volatile and are therefore safe to do from multiple threads. Without the READ_ONCE (reading it as a volatile), the compiler or cpu could turn the reads of info->fs_state in for_each_set_bit() into writes of random stuff into info->fs_state, potentially clearing the state bits or filling them with garbage.

Even if this is right, it'd be rare, but it would be exceeding weird for a message to be logged listing an error and then future messages be logged without any such state, or with a random collection of garbage states.

I can send another patch if this explanation seems reasonable and you'd like it separate; or maybe this is too unlikely to worry about. Thanks again for the review!

Sweet Tea

