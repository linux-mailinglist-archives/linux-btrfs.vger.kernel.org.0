Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135464B17E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 23:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344789AbiBJWEY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 17:04:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344791AbiBJWEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 17:04:23 -0500
X-Greylist: delayed 7744 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 14:04:20 PST
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E07BFD0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:04:20 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 383A99BC8E; Thu, 10 Feb 2022 22:04:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644530659;
        bh=X5iH7SAXsVOy69HNGO0jcR/yN9f9rLAWo9cX5938tXM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=WhSqVnKYQS4VD0EEZPxX9UzTUI8qMypdxfZq9wJY7BdLq5YqmnBXcLjArkvexKkh+
         8xIL/kn7lHV2/vNj8YDbbmKOfw9z6eWFX3e80iMfgy7S3ZbsRQGIm/087TmR0geN5v
         l1zUkiYVlZZ3J8V/7wHwHTVaRvIG6ksVZ0Mck1LlLDtXG451Zz6eMcXgI5m/52oF79
         VyxdHCm89UuZIjXm1bw/t9YVkyIoUBoGlnBX5Ydmco+eJIC5CfPQi8YqGOhyJB5KYG
         wOV2XJm+8PaMsk0u9gb378w9nG3IlCaLZfEnPkis3Mrepjo34V9k8VEc0VqWXcrzxm
         2CpCv/mn5Ggug==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 04A019B7DE;
        Thu, 10 Feb 2022 22:03:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644530607;
        bh=X5iH7SAXsVOy69HNGO0jcR/yN9f9rLAWo9cX5938tXM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=XLeibTCJn6Ss/QhGIhl8IqJM4uypd/5sSZLqzKuF3wzX51R7WO2GFZgPma37YqUOA
         9Db9NR3JvdVFZAnGmIDG8VY8r+RrvdPZe93F6ha3cWtPUfZOuYHDy/OkQseOshuJhC
         F5S5IyaNlxd9fFLMRT6EcqccOTKC9JV6VMMEcZLPXRqvm3k5tE7KFgkNqQjEqsYnnN
         9TZkf6jjNMJdfg1bb3ltqe587FjFQD0i3Le9120YNCUmhyf6FsPy4Y97d7jn2SSpQI
         Ah2ACk64AU5pdBCGqeoaISVzkmaIud70hOVzHpyvDVz4nSUo6q+KgL6ilKhi9nDZ8f
         5JYI/+/UlklRg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 5BF2911EFD7;
        Thu, 10 Feb 2022 22:03:26 +0000 (GMT)
Message-ID: <938de929-d63f-2f04-ec0a-9005ba013a2f@cobb.uk.net>
Date:   Thu, 10 Feb 2022 22:03:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH] Fix read-only superblock in case of subvol RO remount
Content-Language: en-US
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, fvogt@suse.com
References: <20220210165142.7zfgotun5qdtx4rq@fiona>
 <2db10c6d-513a-3b73-c694-0ef112baa389@cobb.uk.net>
 <20220210213058.m7kukfryrk4cgsye@fiona>
In-Reply-To: <20220210213058.m7kukfryrk4cgsye@fiona>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/02/2022 21:30, Goldwyn Rodrigues wrote:
> On 19:54 10/02, Graham Cobb wrote:
>> On 10/02/2022 16:51, Goldwyn Rodrigues wrote:
>>> If a read-write root mount is remounted as read-only, the subvolume
>>> is also set to read-only.
>>
>> Errrr... Isn't that exactly what I want?
>>
>> If I have a btrfs filesystem with hundreds of subvols, some of which may
>> be mounted into various places in my filesystem, I would expect that if
>> I remount the main mountpoint as RO, that all the subvols become RO as
>> well. I actually don't mind if the behaviour went further and remounting
>> ANY of the mount points as RO would make them all RO.
>>
>> My mental model is that mounting a subvol somewhere is rather like a
>> bind mount. And a bind mount goes RO if the underlying fs goes RO -
>> doesn't it?
>>
> 
> If we want bind mount, we would use bind mount. subvolume mounts and bind
> mounts are different and should be treated as different features.

Yes that's a good point. However, I am still not convinced that this is
a change in behaviour that is obvious enough to justify the risk of
disruption to existing systems, admin scripts or system managers.

> 
>> Or am I just confused about what this patch is discussing?
> 
> Root can also be considered as a unique subvolume with a unique
> subvolume id and a unique name=/

But with an important special property that is different from all other
subvolumes: all other subvolumes are reachable from it.

