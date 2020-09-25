Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A927278AD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 16:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgIYO2y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Sep 2020 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgIYO2u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Sep 2020 10:28:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4406BC0613D3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Sep 2020 07:28:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e7so1988284qtj.11
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Sep 2020 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=B5QlhVnST+Y2dR+erjgTepPnjkbFk+KEHylVHZ27V9Y=;
        b=WmQHu43ezIdzs1SEEXfT52nhSk1Kk5qRzpt9rGPZkOdGDLIeXwenwEbr0mNYKdbodj
         mePQ8sajP2zU8V5Mvh4yT2jR/2PIfTYuF0cXaVg9HldEJJXbnMThaK3w/RwYcUwULpFM
         CmCFVcq4c3n6wgeoY4MQOcatc7+pNbu7qA9SU+LcouRnAMu4KM8dfr4Wg/qmc7NJKHUH
         vjRxZpb+tT/wKjSfGtIV90fdNGyGWHIch3UhGEsWCKJMTSM5UaiVE2J2Dqhif+LCImeV
         EBuA2vlr3fiMOttUTslesvUqOvh6gzH86s2FH7QStPJeK007uCULq98Mp0/x0bUhrWh5
         atgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5QlhVnST+Y2dR+erjgTepPnjkbFk+KEHylVHZ27V9Y=;
        b=WYogTwNBQgsqD3EJjlXYl7TnpiR7jjOC4qpK+dswN6JdmsmPNwPGt1TpUVogaAiQAF
         ekZhhmSA5m6wRcsi0lFkQzw1HlcECd9QZ3xvAF3W8dhe4Qm80GFPr4c7ZhF/c7lOexzg
         ab2dKCjZe0Ut4Uo5H7eoJKh4BUIBS+Xvwd+wIGYUOJpSb34cPJKa3Qh/xJBE3cd650Ql
         k56sSYKL1AQ+ezwkryG4VcX+CF2IMHs45oJ04j8Uc9rdqKzMSbvE/OkIZExtMy4oczGs
         kw6Xg5m95kuOMy1o4ROgv4N2cqIZ3hKjyGrEdL3tZ9A0iEYZOW6VVgTZJQOF4VnCjuvz
         pkdw==
X-Gm-Message-State: AOAM533PR+qgN5j3Ed6rCMzZ1JgccB/GfvvXJNuKnPxkTbV8g3fkWwvl
        AFgaWCybuM6I7yQzmshm77hasg==
X-Google-Smtp-Source: ABdhPJzRfm7k+U8370wjyJzeSSy9Iombhu2p1uU/bkzFNu/20pN5JxnAG6VdNGB6VpL9SY+H+q0b4g==
X-Received: by 2002:aed:2f42:: with SMTP id l60mr4740666qtd.234.1601044129313;
        Fri, 25 Sep 2020 07:28:49 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w59sm2066907qtd.1.2020.09.25.07.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 07:28:48 -0700 (PDT)
Subject: Re: [PATCH add reported by] btrfs: fix rw_devices count in
 __btrfs_free_extra_devids
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org,
        syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
References: <b3a0a629df98bd044a1fd5c4964f381ff6e7aa05.1600777827.git.anand.jain@oracle.com>
 <4f924276-2db3-daba-32ec-1b2cf077d15d@toxicpanda.com>
 <3d5fdbd9-7a2c-d17f-62b7-f312042c7e0a@oracle.com>
 <a9910086-ad40-2cc8-8dd5-923ba6ff3990@toxicpanda.com>
 <20200924112513.GT6756@twin.jikos.cz>
 <a6766b76-a1fd-4011-5290-11406bc2923e@toxicpanda.com>
 <b93a6de0-96f7-11f1-e4ac-59de97d60cc0@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7b481788-110e-b2a7-607c-2f443f30f663@toxicpanda.com>
Date:   Fri, 25 Sep 2020 10:28:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <b93a6de0-96f7-11f1-e4ac-59de97d60cc0@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/25/20 6:11 AM, Anand Jain wrote:
> On 24/9/20 10:02 pm, Josef Bacik wrote:
>> On 9/24/20 7:25 AM, David Sterba wrote:
>>> On Wed, Sep 23, 2020 at 09:42:17AM -0400, Josef Bacik wrote:
>>>> On 9/23/20 12:42 AM, Anand Jain wrote:
>>>>> On 22/9/20 9:08 pm, Josef Bacik wrote:
>>>>>> On 9/22/20 8:33 AM, Anand Jain wrote:
>>>
>>>> Yeah I mean we do something in btrfs_init_dev_replace(), like when we search 
>>>> for
>>>> the key, we double check to make sure we don't have a devid ==
>>>> BTRFS_DEV_REPLACE_DEVID in our devices if we don't find a key. 
> 
> 
>>>> If we do we
>>>> return -EIO and bail out of the mount.  Thanks,
> 
> 
> I read fast and missed the bailout part before.
> 
> If we bailout the mount, it means a btrfs rootfs can fail to boot up.
> 
> To recover from it, the user has to remove the trespassing/extra device
> manually and reboot.
> For a non-rootfs, the user would have to remove the device manually and run
> 'btrfs dev scan --forget' to free up the extra devices.
> What we are doing now is removing the extra/trespassing device
> internally.
> 
> IMO. The case of trespassing/extra device trying to sabotage the setup
> is a bit different from a corrupted device, in the former case
> resilience is preferred?
> 

Well this doesn't happen in real life right?  This is purely from a fuzzing 
standpoint, so while resilience should be the first thing we shoot for, I'd 
rather not spend a long time trying to make it work.

In the case of just randomly deleting a device, I don't think that's a decision 
that the kernel can/should make, we should require a user to intervene at that 
point.  That makes failure the best option here, thanks,

Josef
