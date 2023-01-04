Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A5865DB37
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jan 2023 18:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbjADRXm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Jan 2023 12:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjADRXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Jan 2023 12:23:41 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D2313DC1
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Jan 2023 09:23:40 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d15so36534284pls.6
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jan 2023 09:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirantis.com; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vnY79o+5P/8BnAJJkUFD8C6A72Ra9HMzdPraCVdcwsw=;
        b=BZmHrVd48maJP9YcWosJPolo4zApSqO5mFaBUgRtchyC8DDP/y/xqskUw7Nejt3rbB
         Kv3bLQaSipPuYZp4cTo+dM2YC+xOx7TqHRaT7XF1mCbRglbwBw7MKzBBOtOGBPWcPAe8
         NXX/q8RgPd9R3cI0nMj7W+k5Lo8b8jQL8NGG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnY79o+5P/8BnAJJkUFD8C6A72Ra9HMzdPraCVdcwsw=;
        b=Bjm3hVKCzg4aPlQphJ9ZFD4VAUh4qJO96PfLu8O7I41C0XynAlsp6ic0K70SFe6NpM
         o0+yB5S6oZCqBXffQkUFcomo1wwfIqO+IkKsAdItyw70zj+EeGSE0xH8Uqdq0e9CGej1
         XY62IZ12Zk90oGB0MxJZqj28qKOSsPMUAHhwuBrj+ZcUHajhM2kiBh07azjbPo/ZuvdI
         ityGQlPr5mSUrfT+AY67Xg0MesiiykrpeNkwpaBbAKs+G79riaSATG0ZgFlUaS9eoFFT
         W3Q7ZrHJYZTWLV5WBFUz7/zO+m9PQVUECkgkaOTEWN55Wybks1qinj3A+ygs91Os9NpE
         r5JA==
X-Gm-Message-State: AFqh2kouOicW72kv+cEmUu4mnwDVV89HEllyhaAvN8FbTs2FgypQGtuW
        PWONxqSEHbtEAPUkneGe4Vn2ZZr9AxCUtawMPpezng==
X-Google-Smtp-Source: AMrXdXvmvus8c4xh3aGqOhIIKtak284w85qCSPNbqxnAYN5Umm6Qc65Ky61jaGLglvQ6CToe78i2hA==
X-Received: by 2002:a05:6a20:d819:b0:b2:3b40:32b1 with SMTP id iv25-20020a056a20d81900b000b23b4032b1mr56324080pzb.57.1672853019996;
        Wed, 04 Jan 2023 09:23:39 -0800 (PST)
Received: from ?IPV6:2605:a601:a994:f100:85a1:db91:1322:e3ef? ([2605:a601:a994:f100:85a1:db91:1322:e3ef])
        by smtp.gmail.com with ESMTPSA id d68-20020a621d47000000b005813f365afcsm17013191pfd.189.2023.01.04.09.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 09:23:39 -0800 (PST)
Message-ID: <e26a7970-0582-066e-6d6a-cbc8fff6fb73@mirantis.com>
Date:   Wed, 4 Jan 2023 10:23:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: btrfs-progs 6.1 broke the build for multiple applications
Content-Language: en-US
From:   Bjorn Neergaard <bneergaard@mirantis.com>
To:     dsterba@suse.cz, Neal Gompa <ngompa@fedoraproject.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
References: <CAEg-Je8L7jieKdoWoZBuBZ6RdXwvwrx04AB0fOZF1fr5Pb-o1g@mail.gmail.com>
 <20230103113941.GN11562@twin.jikos.cz>
 <22447f37-50fa-3914-a817-e95b66797944@gmx.com>
 <20230103120640.GO11562@twin.jikos.cz>
 <227a4fab-eff2-2a7f-2e01-5de5205d3439@mirantis.com>
Organization: Mirantis
In-Reply-To: <227a4fab-eff2-2a7f-2e01-5de5205d3439@mirantis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> For older Moby branches, we're looking at using libbtrfsutils going 
> forward.

As a slight update, it turns out this is not viable, as only btrfsutil.h 
is packaged by distros packaging libbtrfsutil -- we had not realized 
that the GPL-derived headers present in the libbtrfsutil subproject are 
not distributed.

Bjorn
