Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300DC65C594
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 19:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbjACSBR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 13:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbjACSAt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 13:00:49 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A7B2F
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 10:00:49 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d15so33426315pls.6
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Jan 2023 10:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirantis.com; s=google;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zZGIslnrF5xW/7g8zCW3gwId2EalDMv3dDRewzLN6Zs=;
        b=MV2IflpDEhY22v2TJW/WItwbYFKxsspvJ6KOlvr4s7ArWM2zSYP+unh+G7FoU07S1S
         65fOf1PvxcHa55LXMaAVJEyFJkzBQcvHZFGioUNGLjYXBN6dxeLZD3d4ac/RW4AMzOEo
         Vsiwg6pscEp9F1OqGl/QoHHpA8AZncI9+1huQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZGIslnrF5xW/7g8zCW3gwId2EalDMv3dDRewzLN6Zs=;
        b=o1v+B03O+nUkUF3T2V9HCyu91QWtLEAekDy3OieEpL6FpGIAsKa6knfEHkYCoFZgPA
         9qfn5AVxU+8dPousnT1AuE4SROREyG07frsTSPS7zrynutc6Qu9de3uS7zltafIkit22
         9fTBiQnxWzZgzHyRIhs6o95wonbStCmYLIaRDxL1zMVjekXtPKgR8D4hoOi4wuRS50ZY
         14VdI6gh3JYy//pY1ogLRiC2HF6iR+xF/tKrS4McK6SR66sOos3nC3S1oHZelabJdlr9
         oxCg/mlR6L/hggcatTbVB1NctCm0j/+d0TcublFy5DWRotSgVdfPdKZpl5gKtoMe7uM8
         n/CA==
X-Gm-Message-State: AFqh2kpAQ46FrqTeLvZJKfDXG7rFkqxVnIR7BG88KTBgUF/f9dmYU+b1
        JFMQfWLPaiqrb6BKiUu2G6zgiw==
X-Google-Smtp-Source: AMrXdXtaPBjNhVT89Hj4oJ9AshRIG4ikBW3f2lOPdnkXU7TlFLaa7S9yPx6WPTmGwN0ZfgMlX0nuDA==
X-Received: by 2002:a17:903:28d:b0:192:85f3:5b1 with SMTP id j13-20020a170903028d00b0019285f305b1mr30393211plr.59.1672768848506;
        Tue, 03 Jan 2023 10:00:48 -0800 (PST)
Received: from ?IPV6:2605:a601:a994:f100:a9f5:89f1:4259:b105? ([2605:a601:a994:f100:a9f5:89f1:4259:b105])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001926ccaa4bcsm19297964plg.161.2023.01.03.10.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 10:00:48 -0800 (PST)
Message-ID: <227a4fab-eff2-2a7f-2e01-5de5205d3439@mirantis.com>
Date:   Tue, 3 Jan 2023 11:00:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
From:   Bjorn Neergaard <bneergaard@mirantis.com>
Subject: Re: btrfs-progs 6.1 broke the build for multiple applications
To:     dsterba@suse.cz, Neal Gompa <ngompa@fedoraproject.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
References: <CAEg-Je8L7jieKdoWoZBuBZ6RdXwvwrx04AB0fOZF1fr5Pb-o1g@mail.gmail.com>
 <20230103113941.GN11562@twin.jikos.cz>
 <22447f37-50fa-3914-a817-e95b66797944@gmx.com>
 <20230103120640.GO11562@twin.jikos.cz>
Content-Language: en-US
Organization: Mirantis
In-Reply-To: <20230103120640.GO11562@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey all,

Just wanted to chime in here from a Moby (Docker) standpoint:

On 2023/1/3 19:39, David Sterba wrote:

> On no that's bad, I'm going to do a bugfix release today.

For what it's worth, if we need to have a flag day, this is probably the 
time to do it. The projects in the container ecosystem are reacting by 
moving to libbtrfsutils or adding a define, so the damage is mostly done 
(there at least), and I would suggest that distros can carry patches if 
they need to use newer btrfs-progs with older tool versions.

Or, at the very least, this seems advantageous from a btrfs-progs 
maintainers standpoint, and should be scheduled to be re-implemented in 
a future release. Perhaps it could be gated behind a personality define 
until it is made the default?

On 1/3/23 5:06 AM, David Sterba wrote:

> On Tue, Jan 03, 2023 at 08:02:27PM +0800, Qu Wenruo wrote:
>> I'm a little confused, why would those projects relying on the ioctl.h
>> from progs?
> Because they're probably using the legacy libbtrfs and headers from
> /usr/bin/btrfs/*.h, it'll take time before all could be switched to
> libbtrfsutil.

For older Moby branches, we're looking at using libbtrfsutils going forward.

>> Shouldn't those things got exported through kernel uapi?
>
> The kernel UAPI reflects what the installed and possibly running kernel
> API is providing, interfaces that can be used at run time. But the build
> can be against any newer version even with functionality not implemented
> by the kernel. Think LTS stable releases vs updated btrfs-progs.

Going forward in Moby, we're planning to depend on the uAPI, until there 
is something we need that is not widely available. Currently, only EL 
7's 3.10-series kernel does not include the structures we need in the 
uAPI headers; as such right now it seems reasonable to depend on the 
kernel headers instead of an additional userspace library.

This is largely because RHEL 7 deprecated Btrfs support, and while it's 
supported in Oracle Linux 7, that is only with the UEK, which will have 
an updated uAPI. Interested vendors (e.g. Mirantis)/users can still 
build for a 3.10 kernel with Btrfs by providing their own headers.

Bjorn

