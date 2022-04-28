Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67C513ECA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 00:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353099AbiD1W71 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 18:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353087AbiD1W7Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 18:59:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D82E694
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 15:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651186563;
        bh=SY4hGqnLeBloezOA/3lrTAGRAY/abGA7AuzCl9DMHJ0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=B8LPvDKTt1kmx/umSgzvYXStprrb+OunbyjLEiXH0Ivh0l+u0WUSK5OSLZtlHCknn
         oWmiab+tuPyFKm0zigigg7HGvmPUolHajMnC5jjV8RAoQgdDh7kJDnh1lHrQbtuKXe
         krHz0H8PjlDlmaXstuXsVzWe42Kq3ibRRIST4pyw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTzay-1nJMXo1e7O-00QxqI; Fri, 29
 Apr 2022 00:56:03 +0200
Message-ID: <4ac0c01f-73f6-e830-f3bc-6281bd79b7d2@gmx.com>
Date:   Fri, 29 Apr 2022 06:55:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v2 05/12] btrfs: add a helper to queue a corrupted
 sector for read repair
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1651043617.git.wqu@suse.com>
 <a136fe858afe9efd29c8caa98d82cb7439d89677.1651043617.git.wqu@suse.com>
 <2fd10883-5a4d-5cbd-d09f-7a30bb326a4a@suse.com>
 <YmqaOynJjWS2XB76@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YmqaOynJjWS2XB76@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ij2PxYjBAPeWNb6eUjAgRYQWIeJpJBJ951U5jrZr6BtBZI+S6i+
 wkvjqugPkzS5g6h4/NUTLoXTtwkcLRsr95GH7u4pBDjtLfsQX2ftQR/WE75D5J4XgS2I9cq
 JatBlLHnP1ykOn2R03BGUtnbOEaF2RCzBbesOiuI3Ut7lJuLoDLByyDxFH0NR4Kmfy5WPwg
 9QM/PPhE85sfLRo0TU1dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lSiBwArr/kc=:7Mvw/erG12ruIwT4popf5E
 wtg2Gpl5LpmzTlg649BhWQDVVEeokRASzA45kYpfbIbfbLx1yKSINxiFShENUu3k2+xMnUsBG
 IAmKCOlhTBTcEl0G+Qp2NiSnYZLX2WuCGswfYBddpH/FX5pCX/VQsvzN7s5avU0nFfm14bVBf
 ltczWC0ncGOUewNvHqjcGLcBzGqU6fev8s7sMQsLPDvNU5dXEjqV7duXZVTgooP4U3bzYhxvI
 L9ihxNOi1kun1oH2+amXW6Um0vBiYi7W0+27VUTxc1fxCu5B/t8zRXszZqO4KGVZMHcwh2Z34
 OWd7OPtM5tSF8GyvDSPD7IlsPhmRqbKinO8jrKUR2p8VSsCs9AivKHY3jwttc4Jf1MisAVviI
 wbPwLeUzIrkOcgvvUE/aoY7Sr1sH6fkqcNt8sM75KhCqtDcnxoDGrEq5zdix6kpRSyaZfiuOE
 7nMTqbcV80LvXc9CK5vlj1hT7tcq9R1PE+1K/2HVio1aPhSbPX1xF0fhHac2KmxX8m+QKGinz
 IrqB6IGMFx2+UQhZxvLavbtyqONf/us6kJPRoikPoPEzt+OEAt6ZAdmDL/VOdL4wrIxOmVVKM
 QWVXtnVwyveQaioMzeZE8pG4WooZYXIcALSSUKtSDjEOF7Y0dB4yqsu4lF1/n6y/YRz2K7c9x
 y0zKODWmoAzpXTwSiUfnELig3rq5kixARR6dZX2fw+XCsTMvYzMTRYG18XF8o1VgUhzHUmeFb
 f8Q16l8jIRelqQ/RYhXI+8iaIEQbQI+L1t87/80qFR4vQVneCAZv2ykQi6k1rjhW1X1lYJTlr
 iRN6OT5Ycvm97bBcLfVd1R4rkIRWYfhMQVbU6BSlm9BAuVwzivDZyJAlBiz5BJNyP9SLJjjrJ
 wo09T6ujAS0zImxEpWSgzF/xuFGDSbUlMPs1n5rwKn8qzs5eANNz3nNMeQKAlj7ZbOkgB2/Ms
 N79nJUooX+PD/RbfyVRsbmVv6lWN10nZ59PTYR5lMWNnNG2Ngr3iRNT4bRL6yfMV1a2Fslly9
 7OgzYYY8HkdHI2q5cxUeQy4e5gCVyICxVocqNMQL75Wgb7dHRI2NBSwMcBTu2Nb+24U1a2Fhd
 RCt7H9xKIy9lVU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/28 21:44, Christoph Hellwig wrote:
> On Thu, Apr 28, 2022 at 01:20:37PM +0800, Qu Wenruo wrote:
>> This function will get called very frequently, and I really want to avo=
id
>> doing such re-search every time from the beginning of the original bio.
>>
>> Maybe we can cache a bvec_iter and using the bi_size to check if the ta=
rget
>> offset is still beyond us (then advance), or re-wind and re-search from=
 the
>> beginning.
>>
>> I guess there is no existing helper to do the same work, right?
>
> It is basically impossible to review this because you just add a
> standalone static helper without the callers.  Please split the
> work into logical chunks that actually are reviewable.  Yes, that will
> be a pretty large patch, but that's still much better than having to
> jump around hal a dozen ones.
>
> No, there is no way to efficiently look up what bvec in a bio some
> offset falls into, because the bvecs are variable length.
>
> It seems like the caller (at least the one added a little later, not
> sure if there are more) is iterating over the bitmap and then calls
> this for every bit set.  So for that you're much better off making
> the __bio_for_each_segment the main loop, and then at the beginning of
> the loop checking the bitmap if we need to handle this sector.
>
>
>>> +	struct bio_list read_bios;
>
> I'd just calls this bios.  Obviously they are used for reading here.
>
> Also please be very careful about dead locks.  The mempool for the
> btrfs_bios is small right now, you need to size it up by the
> largerst number of bios that can be on this list.

In fact I have some version locally checking the return value from
btrfs_bio_alloc(), if we failed to alloc memory, then just mark the
btrfs_read_repair_ctrl::error bit, and mark all remaining bad sectors as
error, no more repairing.

As memory allocation failure is much more a problem than failed read repai=
r.

Another consideration is, would it really dead lock?

We're only called for read path, not writeback path.
IIRC it's easier to hit dead lock at writeback path, as writeback can be
triggered by memory pressure.

But would the same problem happen just for read path?

Thanks,
Qu
