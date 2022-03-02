Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBADA4C999A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 01:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiCBABl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 19:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbiCBABj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 19:01:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925E18EB46
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Mar 2022 16:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646179247;
        bh=ocClqD5ZNZG6pqIYNX0bS1w+RwbO01YSeY1JEuQlIPU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=MtuBDCGpvYiFCRJzDDwQJuJzAjTP4adNeAVUqeaxBp+5J2OF+edpQqSbF7SGoiRK1
         eEi4CpfOHj+sYQA2fITDjfNxLH5VYYApLPSsOeCbopqyu3Oc7Ey/PlBs4D2C5DuTKe
         t0IhJCiPRCjyEzc/QViYNEbgxYL8hp8wIUCQPaEA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNNo-1nkfBE3Y02-00VRVd; Wed, 02
 Mar 2022 01:00:47 +0100
Message-ID: <2cfc789e-2cdc-0b63-ed65-997e0084f534@gmx.com>
Date:   Wed, 2 Mar 2022 08:00:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Seed device is broken, again.
Content-Language: en-US
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
References: <20220225114729.GE12643@twin.jikos.cz>
 <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
 <YhkrfyzmCgOGG+5n@relinquished.localdomain>
 <f4525052-8938-42f9-543d-c333200353dd@gmx.com>
 <43aea7a1-7b4b-8285-020b-7747a29dc9a6@oracle.com>
 <00f162f7-774c-b7d4-9d1f-e04cc89b2aee@gmx.com>
 <508772bc-237a-552b-5b63-80827a5b268a@oracle.com>
 <4661c891-b15e-3a8f-6b98-f298e104262e@gmx.com>
 <20220228184050.GJ12643@twin.jikos.cz>
 <7feddd5a-856c-a525-a05c-fd682574aa49@gmx.com>
 <20220301170930.GR12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220301170930.GR12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R1KqrCF+rJNcfMJ4OZPCw9F5n3k9AkgcRP0WC2dQasceWM/4qwE
 vNdbKq69Vldg26GKWo0HNWdq7pMbxPqrfUGQ6fhh1+HmN8LqtH3JXefCjVTOd06i4804WNw
 ysk9B458DF0STXtUwHtEmgUwvPNk2Uqi3MHqD4o22thyr75cMUWNXVRj2qC0ZvwP/asokyw
 VyN96JeMife8G5t7DjuWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yFstsIlCLfs=:mYq6ObyjmUFrloTpoTsZr9
 5cd7dwMDUC1KLrTN5BuN9ydIynop5yi6nH7HdAs2Pm2UNleNHjpOD/xBpF2G6lQnDWOzzsBXe
 SmASfVUEplYzdQyIIt/rJwVxWafxKvn1RT7aB9gshZwOA7GLqC9uLZE+XonHsk/Qidu04NQoT
 dUko5xa7CkK76QkVdUhgYYIxLD0AN+QwBoXFhPVmQv4hz6DSDwuRM3+hFLZMSqPgoA3/0BblK
 NFJgo0TAsgtLK0Ej4YNXox5cSw1kKXvQ0qr1pqza3vXF60HKDM2nZhAy862RnN36Zwl9yBZCD
 gL5+qi+UH9cLQqHvlwSlFSTDTEsdKlk3Wa7PMNJkg/IEAmFFPzzIOIL90K9RM1e6hwkxfzNd8
 OaMvQTjpsBIJ8TNdnXVXC1bXEkKtFFx0D1sZwAsX+R6d8C3u20I+kUehu4OsptwU5wbXUhvt7
 lJtShb6qIcMYsORqoVx0m3WxIo3mqO00bs+ymiQ7JafVXnq03RIb4zD16aNmjQRs3YI1lv2ny
 Un8JzHO3vVFSWARylPOiYCF4+nRFev8o56jh0PtMoAYSRsNxIjJKOyM6D7TwholyidkuhPGSt
 PWXKoeDC1lXVBuWykg5xte0pfMTk6yLzeTJvjeYXFF6cqZDYyqIELnGU6lBo87kMYqm9rSS8b
 8BtnUHJ2UPjDyVTpuL1HkW8yE2R/5bmrmTPGyQgQKT7l4JqlCrnBiE2bj7Q+dPkk7zCFHkcLU
 l5hmV4hX0GH44ZTqrCe63YOMjmZkFWV8cyWXKXL9jeWqsiZO5DnaqtGTIUeHfjzoJEBxAbuE7
 K5apbMjaysbjJp/Uvq7G0XKZVfUKDEixFVXOntruAffFbJU4Y7i8uEeIw+EluivNShf869s0p
 B2o1SgFBLQsXlwE+XmnBuW3+fjH3JV+vSY+yw4LUNWmsqd33FXFXjZFaPiH8cTwxx//FTg8Gi
 mBv0wHIB/AgJPd7r9paJVYlUmMCm2hKuhKoVpfXnDtC7FMf/zzkcevxCSasgO/x4B+jaXhNJz
 IWJF1Lmh3UqnEoPKs4Ao33jmahunmmisqA4OS+kpH8qR6oXnjsm6QhwtfbrPQcTu+4i3HegIQ
 ICGAJhTuZcOJBo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/2 01:09, David Sterba wrote:
> On Tue, Mar 01, 2022 at 08:13:28AM +0800, Qu Wenruo wrote:
>>
>>>
>>> There was a discussion some time ago if the log replay should happen o=
n
>>> a read-only mount, or any potential repair action that could happen
>>> regardless of the ro/rw mount status. The conclusion was that it could
>>> happen, and guaranteeing no writes to the block device should be done
>>> externally eg. by blockdev --setro. But I think we opted not to do any
>>> writes anyway for btrfs.
>>
>> My main concern is still there, we change RO to RW without any remount.
>
> We also do emergency remount from RO to RW, so I take it as that
> changing the status is partiall in the hands of filesystem, not
> violating APIs and such.
>
>> It's weird from the beginning, but we just accept that.
>>
>> If we have chance to rethink this, would we still take the same path?
>> Other than making seed device into user space tool like mkfs?
>
> I'm not sure it would work the same way as now, the seeding device can
> be mounted several times in parallel as the UUID is generated at each
> mount, then added the writeable device, then thrown away. Any detour
> through userspace make it more complicated, but I haven't thought that
> through. We could add it no top of the on-line seeding as another
> usecase but if current users are fine with how it works now I don't
> think we need to spend time on implementing it.

Then let me try that.

At least to me, using seed device to create a new RW fs really looks
like a perfect match to mkfs.btrfs.

We already have things like mkfs.btrfs -R to populate the fs.
Using seed device would be more suitable to me.

Thanks,
Qu
