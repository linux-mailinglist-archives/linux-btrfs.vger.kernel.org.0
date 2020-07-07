Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4E2173E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgGGQZn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgGGQZn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 12:25:43 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57642C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=peLmcDz1XvkRGxOE++7CmgnRRBXSI4i+NL6YoDmtlug=; b=Al6sUTOHZ0hKVnWtUsfUYVUUsB
        i6UfQ3UFaIRYMVk5yzzdtG2AWIXZwVXziaB/aEizi8ypkAMYcWeY6IhtxZzMXZ6fcdhK4pIYljQtz
        6RoibLbpoec+KyHpP6BWpNZj4u3DA+ufOzSJnt8XiIkzOJ3E9n/4rOIWiqS9LNXaSHODDhPHzxb0O
        ZMCnEAXFsIiEtjJOxVer9WC8qh+YNWCgG3tdlCb5hb3xbH+YiA4naH2h7BNrXR/L9d7U+QEM8LGrZ
        qe54g7XlaZx2mej9lhZp6OIn6QFQVzoBE2+Zu7hDrRYML2Aor8nDHCGIDr9VKWZjTVkiaT2a76kIv
        WYocaPVg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:64244 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1jsqPa-0006CO-Td; Tue, 07 Jul 2020 18:25:38 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <20200707151621.GA16141@twin.jikos.cz>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <af774c52-8603-20db-a5f5-db14e375ba1d@dirtcellar.net>
Date:   Tue, 7 Jul 2020 18:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <20200707151621.GA16141@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



David Sterba wrote:
> On Wed, Jul 01, 2020 at 10:44:38AM -0400, Josef Bacik wrote:
>> One of the things that came up consistently in talking with Fedora about
>> switching to btrfs as default is that btrfs is particularly vulnerable
>> to metadata corruption.  If any of the core global roots are corrupted,
>> the fs is unmountable and fsck can't usually do anything for you without
>> some special options.
>>
>> Qu addressed this sort of with rescue=skipbg, but that's poorly named as
>> what it really does is just allow you to operate without an extent root.
>> However there are a lot of other roots, and I'd rather not have to do
>>
>> mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
>>
>> Instead take his original idea and modify it so it just works for
>> everything.  Turn it into rescue=onlyfs, and then any major root we fail
>> to read just gets left empty and we carry on.
>>
>> Obviously if the fs roots are screwed then the user is in trouble, but
>> otherwise this makes it much easier to pull stuff off the disk without
>> needing our special rescue tools.  I tested this with my TEST_DEV that
>> had a bunch of data on it by corrupting the csum tree and then reading
>> files off the disk.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>
>> I'm not married to the rescue=onlyfs name, if we can think of something better
>> I'm good.
>>
>> Also rescue=skipbg is currently only sitting in misc-next, which is why I'm
>> killing it with this patch, we haven't sent it upstream so we're good to change
>> it now before it lands.
> 
> Right now we don't seem to have a consensus what rescue= should or
> should not do and given that the patch is not in any released branch I
> can keep it in for-next topic branch.  We'll have something to test but
> unless the final semantics is agreed on, I don't want to keep the patch
> in misc-next to avoid dealing with the fallouts.
> 
> To be specific:
> 
> - patch "btrfs: introduce "rescue=" mount option" only wraps existing
>    options so that one is probably ok to stay in misc-next
> 
> - rescue=skipbg would go to topic branch
> 
How about calling it recoverylevel=xyz or recoverymask=this,or,that 
perhaps be a better with a conservative settings as the default?!
