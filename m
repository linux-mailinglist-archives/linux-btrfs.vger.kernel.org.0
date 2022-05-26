Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8559A534AE5
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 09:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243001AbiEZHh7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 03:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiEZHh4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 03:37:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12D29CC98
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 00:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653550671;
        bh=1v26CrXVNiwl7SfQltRkoZyR3CaHhvArqv3FuBOkPYs=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=OVldLirjac8r/FGkI5P8VGzdfaqulR8Ye5S9wkB4BYh80Lj+g2Q3dgKYJIz+bF8RW
         znfFj802lkQzCRlaElkiHu8HMBJKoDeweu7MNtjVEbk1YxHOiJsONSkeJdkM4GaLUj
         wlnUBxYa8GBcv+rMNzg9GsCM20ZoOEZ6pbkQJDUM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mo6qv-1nVDW91y3P-00peDD; Thu, 26
 May 2022 09:37:51 +0200
Message-ID: <bf92f4ee-811e-35c0-823d-9201f1bceb0e@gmx.com>
Date:   Thu, 26 May 2022 15:37:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1653476251.git.wqu@suse.com>
 <b014412ee0713e01f52269e553c0cff3487ca495.1653476251.git.wqu@suse.com>
 <531d3865-eb5b-d114-9ff2-c1b209902262@suse.com>
 <20220526073022.GA25511@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 4/7] btrfs: introduce new read-repair infrastructure
In-Reply-To: <20220526073022.GA25511@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iY5vt5WLrMOx0Q0VDWI+jPNRCJrO/WGv36TneDpJf05CADZe7uc
 sMxvSuN9iAG5uPJ2G3yahXHCSw0a37cmy+4SAquDhbAB7jUz+RXOKoxDqEXSArzs3qTbAXd
 ETkUlIdJ38hFgdrqmMnehySVL7KQDEMn+tfVxBp9iEEXS8RJDDDfQsSePVcAWOB2Iz+QJib
 3ih79SL+NA4+k4A7kvI/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hc+h/YJ4o8Y=:GShXwBw+2flWrSh4UUNKOU
 KTw8TiOukTm00xq71O3RCy3RMMExxuvPuoH2LuhCtuf/1AFOLuOIJ37oM6CNrZenF4vhch/eF
 CSuceU7GWHdNPZztZGGgJvlxMS/K8PHaCvoXhw9TwBLxw5JxhTJqn4+qZsy/gSNzi88VhkkrE
 V0VSSRVVcG/3ECpJn0GYseO6yMQs8ANRkHNCvcz7JarKBb/To+Pi1c/0su+21ZPo056z82iTm
 aHOtux6xV0uCmXpt5lmR20F8EygKoc6gPJomUXITqBheKT04rkbtLRnGXCEAIRPHuu8obAr57
 Id09Dn0oDTssAtFVtpm/byNaJIflJPvWEUMikaeWZxfh9zk3G6t1bEW8Uy+rXZ+CNhFe42yzb
 oW38Lj/siSkxSw0kNUh6d4oSbJzHu34KHQlVB+3Kb+1LlesZYBwBl/5iO7Q29GFFdos5uhot2
 TzPrKk2Jurlgob7NcI4pgGcS4Qo2TFZIT4HwyTrw525vi4/GU9go34sLyXjmHPPcYX41bLOs1
 O1rkyGkWr2Y0dzaFEyYZpwMRTLT9e/JPXEc+tCTZLPc83JsYmG18bYiTzv89ksTUDZZVOGdis
 y+jZjSVaJbbAucfrWsplGZiebvBrJQKTDFoPjrMRhCGNo8R5DeaYgCzgtKZCe6za4jviQpaEi
 ydB4GwbEjQ2g2mFgYbLUJF1H6TbrszZspC8wUnJgyaoVsD5kPSoNzoWCmVx7KNPvSQb8205Wi
 luRW21iGVHiGupWT2AHrZ8eNA93qS7XMSWu7dXoWD8+I1SdmsTJj3uBBtY422VVCOz+ea06Nf
 Hv7FSolAgjBdNiNfaZ/1+Aip4BuZfV5pOytPmF5YoeJCsM82IEGdqswh3eLUfncHXZ6REl8oL
 2wSxVYDRVLr1wFWcd/c3eGfb6RSfUkddo1KsGNUAr/MYF/oWkO1ggQdJlFuLVklVAmoXQ/Ywm
 tnRdTkzfE+yGYq1n4EIlnNKnmZ6Fq6I5PKpbOOb134r5BB+UOLwGNL04sA2pVcvJpQHMeXzhe
 mnhQrOdHs2AJ9NoXm+zv/0sFIf4anuZwjbjAGCN1TGEAGUywC6IN8atS7/8jS7dhSE5aL6Cgl
 8NDAgd6UR9oCDiyGv+L9LZSUktWXM1COku2ycNzTtMnu9sIkoDs9Q7pCg==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/26 15:30, Christoph Hellwig wrote:
> On Thu, May 26, 2022 at 11:06:31AM +0800, Qu Wenruo wrote:
>> Hi Christoph, I'm pretty sure the non-continuous bio problem is here fo=
r
>> all of our attempts to rework read-repair.
>
> Why is it a problem?  Multiple discontiguous errors in the same bio
> are a very unusual error pattern.  We need to handle it obviously, but
> it doesn't need to be optimized as it is so rare.  The most common error
> pattern is that the entire read will return an error, followed by a sing=
le
> corrupted sector.

Rare case doesn't mean it won't happen.

We still need to address it anyway.

Furthermore, if we can submit one bio to read the whole mirror range,
without putting the corrupted data into our repaired data, it also means
we will have read at most (num_copies - 1) times, without resetting the
initial mirror.

>
>> I'm wondering if there is some "dummy" page provided from block layer t=
hat
>> we can utilize?
>
> For reads nvme (and a few SCSI HBAs) support a bit bucket SGL for reads
> that discard parts of the data.  Right now upstream none of this is
> supported, altough Keith has been looking into it (for a rather differen=
t
> use case) in nvme.  This does not help with writes, never mind the fact
> that I would not want to use exotic and barely tested code and hardware
> features for a non time critical and rarely used error handling path..

I'm not purposing the SGL method, but still do a full range read, the
only difference is, the page range we don't care will be written to some
dust bin page, and only the range we care will be put into the real pages.

E.g. we allocate a dedicated page per-fs (or even for the whole btrfs
module) as a dustbin page.

When we don't want to read some range, we just add that page into the
bio (this means we may put the same page into the bio several times, and
the page may be utilized by several different bios at the same time).
And submit the bio.

I'm not sure the current code base can handle the case though.


For write, it's pretty simple, we only writeback the whole correct range.
If we didn't recover the full corrupted range, we just don't do writeback.

Thanks,
Qu
