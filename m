Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0C6A9052
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 05:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCCEwb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 23:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCCEwa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 23:52:30 -0500
X-Greylist: delayed 1081 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 20:52:28 PST
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE92520D3D
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 20:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1677817262; h=Subject:From:To:From:Subject:To:Cc:Cc:Reply-To:In-Reply-To:
        References; bh=pNDBITORFr0lsd79RLRPh8cLWh1ltVx4GmDTwYJ1vjM=; b=xNmE9YQLfzAczc
        XI1rFm98F7mNzfYt9cPw8tkbe1AAvl6hmVx8AAc9f1EYZkdEBCB9XMdFAZ4F+Xx0SH07krIxKQynz
        9f1ubTJmggx0AgbCFtZFZoKoI0zrT9ChDBN8v2LhvN6f5KibuNs0dM/WLfwa20nKeZrcuDZgDH8dw
        upnaIjQ/gvW/ageQwqTVJ6ppAQ1GwEXFvbV8KssYbyMaho9NRYanLKhqlt9lFa03/YZHG+X2o+itN
        1pVXnITN/dNIHbfIVHCpm+moEaiyJSapO0BEuoHUIg6y7YSTl85y8/oQiYse/goK2y1/CMfvuNlfl
        6DKXYuQf65Qv1jzctwGg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1677817263; h=Subject:From:To:From:Subject:To:
        Cc:Cc:Reply-To:In-Reply-To:References;
        bh=pNDBITORFr0lsd79RLRPh8cLWh1ltVx4GmDTwYJ1vjM=; b=u/7esVZtTgncxJGNaiCwield6H
        hegt2kRQGBM+4KzvhdHPq40p0NZgtBte9A7Fj+pSQL9rINjP/2dX7yeb9uF+zDHVlSU/EhkBUNGHB
        7pslCd8wW2EuqhlcOft7612rOSTDEksfLJZ/yQ/g1tCih2eLfSGwf0DcIe/ddrL7qt5qrqJZYtLyU
        jEr3Z8S4MtnlsuvQcLm/rUpb115EyR1eoRyLs0adkGwTMamKidhWJz2Wta8zAWzUUPm3K62cBj8FF
        xD6XLfvxn4m37J2A7dAfVHkutmOf5b0WdVtjwl/5wv/QXBF8V8yIlx4vFTMUrXP80FsiTgnQOdbDO
        s5guUU+Q==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1pXx7j-0006Kr-0v for linux-btrfs@vger.kernel.org;
        Fri, 03 Mar 2023 04:34:27 +0000
Message-ID: <59b6326d-42d4-5269-72c1-9adcda4cf66c@bluematt.me>
Date:   Thu, 2 Mar 2023 20:34:27 -0800
MIME-Version: 1.0
Content-Language: en-US
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Matt Corallo <blnxfsl@bluematt.me>
Subject: Salvaging the performance of a high-metadata filesystem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a ~seven year old BTRFS filesystem who's performance has slowly degraded to unusability.

Its a mix of eight 6-16TB 7200 RPM NAS spinning rust which has slowly upgraded over the years as 
drives failed. It was build back when raid1 was the only option, but metadata has since been 
converted to raid1c3. That process took a month or two, but was relatively painless.

The problem is there's one folder that has backups of workstation, which were done by `cp 
--reflink=always`ing the previous backup followed by rsync'ing over it. The latest backup has about 
3 million files, so each folder varies mostly around that number, but there's only < 100 backups.

This has led to a lot of metadata:
Metadata,RAID1C3: Size:1.48TiB, Used:1.46TiB (98.73%)

Sufficiently slow that when I tried to convert data to raid1c3 from raid1 I gave up about six months 
in when it was clear the finish date was still years out:
Data,RAID1: Size:21.13TiB, Used:21.07TiB (99.71%)
Data,RAID1C3: Size:5.94TiB, Used:5.46TiB (91.86%)

I recently started adding some I/O to the machine, writing 1MB/s or two of writes from openstack 
swift, which has now racked up a million or three files itself (in a directory tree two layers of 
~1000-folder directories deep). This has made the filesystem largely unusable.

The usual every-30-second commit takes upwards of ten minutes and locks the entire filesystem for 
much of that commit time. The actual bandwidth of writes is trivially manageable, and if I set the 
commit time to something absurd like an hour, the filesystem is very usable.

I assume there's not much to be done here - the volume needs to move off of BTRFS onto something 
that can better handle lots of files? The metadata-device-preference patches don't seem to be making 
any progress (but from what I understand would very likely trivially solve this issue?).


Thanks,
Matt
