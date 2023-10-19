Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7233F7CF1FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjJSIGj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 04:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjJSIGi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 04:06:38 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27F2121
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U8Rksq9rYoDG/MDEFrKWxe5+lyapQwSQjCwkI4+gmA4=; b=d1q5mwfnys8CdyaR9p6nRKCr7q
        1B19JgAfjWO3Fxj8FV/dmhtOc+UIgRC6GdUwb94azsyY5cheR78cFFo47f8+9mfTgzm2nq6m614nb
        18d4K3jxbj6+K9e5Tsp+IlZUqizZApEfqCzBztQOaGF6LS8oi4j6jcC4QXZQemzjlBMYd9jQN2cJC
        7OTcYUMJ3LMys6E213DoWnzHDzYsWA+vO2wxb4bhtz7MgrlX0sAFyBEO5Z06e3Vq/+TIM2hgjK83V
        U2bKK8/ULiEWTDskKaP6tVyt9BN3QqZZThuauo+aerfdAw78IQnHY/fsAGdgn+WxCeobAwcaxDxum
        stya81Ww==;
Received: from 44.red-81-39-191.dynamicip.rima-tde.net ([81.39.191.44] helo=[10.0.20.175])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qtO33-0028M7-Ms; Thu, 19 Oct 2023 10:06:29 +0200
Message-ID: <406820ef-1c71-53da-3bb6-460f782f2aa7@igalia.com>
Date:   Thu, 19 Oct 2023 10:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] btrfs: sysfs and unsupported temp-fsid features for
 clones
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>
References: <cover.1696431315.git.anand.jain@oracle.com>
 <20231006150755.GH28758@twin.jikos.cz>
 <9cfb8122-4956-4032-b9ab-2eea8bb19415@oracle.com>
 <dfb5e1fd-6eb3-b0bd-d5c6-0f5f9179eec4@igalia.com>
 <a17167c2-fea3-4f48-b381-d72585b35845@oracle.com>
 <20231009235910.GY28758@twin.jikos.cz>
 <179437dc-8be2-2ff1-e8c5-a322c29f13da@igalia.com>
 <20231018230413.GD26353@suse.cz>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20231018230413.GD26353@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/10/2023 01:04, David Sterba wrote:
> [...]
>> Anyway, thanks for your improved approach Anand and to David: is it
>> expected to land on 6.7?
> 
> Yes, what's in misc-next is queued for 6.7, also we have the whole
> development cycle to fix remaining bugs.

Thanks a bunch for confirming and all guidance through this feature process.
