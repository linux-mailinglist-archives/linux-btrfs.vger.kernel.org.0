Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008DE2113CF
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 21:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGATpx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 15:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgGATpx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 15:45:53 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAABC08C5C1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jul 2020 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yJ1NrbjVlD6ThLXGj2QOqh/t82Etw80sk3P9v/7fN8A=; b=BS7GeLuY99+BHiu9iFcfQEoRPE
        E6IGJUzalANu30IXrNvJB8dhUVwKvhW9dGo3nIcUTRam2x4h/TgaD5b2MOFXlflOCwc4GNeeinyX+
        xs/zZ/e6ReTnNY8O4HrqTVNUgjIObBJxtVN8zPakr+5R1isxiOnDaAQwWFj5cd/wFSAXL8V+EXfMW
        x9xLfzMDYbNkMmjQu7xl60FRF7Io7SjzackffMWNkr6lug6/yBpuBO7DMadw4ocZTn6H5YA4o4UQ6
        u96nKylZTqKNPnzJkC3/nxsCpiZwENQN8/dTYLcz2YfcA+HLiDexIMdYyKmCCxY0UKunS+y9DiXIz
        oFL3eRew==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:51736 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1jqig3-00069T-3B; Wed, 01 Jul 2020 21:45:51 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
From:   waxhead <waxhead@dirtcellar.net>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
Message-ID: <54893087-38dc-4e80-7a6a-3784b84df02b@dirtcellar.net>
Date:   Wed, 1 Jul 2020 21:45:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



waxhead wrote:
> 
> 
> Josef Bacik wrote:
>> One of the things that came up consistently in talking with Fedora about
>> switching to btrfs as default is that btrfs is particularly vulnerable
>> to metadata corruption.  If any of the core global roots are corrupted,
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
>> everything.  Turn it into rescue=onlyfs, and then any major root we fail
>> to read just gets left empty and we carry on.
>>
>> Obviously if the fs roots are screwed then the user is in trouble, but
>> otherwise this makes it much easier to pull stuff off the disk without
>> needing our special rescue tools.  I tested this with my TEST_DEV that
>> had a bunch of data on it by corrupting the csum tree and then reading
>> files off the disk.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
> 
> Just an idea inspired from RAID1c3 and RAID1c3, how about introducing 
> DUP2 and/or even DUP3 making multiple copies of the metadata to increase 
> the chance to recover metadata on even a single storage device?
Obviously I am drunk... RAID1c3/RAID1c4 and DUP3/DUP4 of course... :P
