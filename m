Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A154ECF9A
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 00:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbiC3W0r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 18:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351579AbiC3W0q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 18:26:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1F756213
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648679091;
        bh=jTx3bkVJ4RANOjrko4lpD5zz8I7URAWIhJIxKN++4zs=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=hJC/iY98mOoSWhz5TulVJokbdd5AqDAbF/V0fDtsLfFPvlhCQ7qSlmWmTwRfjXDgm
         guFRYA3PTGfKrYDEpUD1hsvlEoQXbCrMKFQ5/eeqr2oAdn14qoayjx9ilYxPrU/JSE
         ynLu/AE+ItMETcsRBReWoUTMs4iza3B4VJQ+qriw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3KTo-1o0SzQ2jgI-010ObL; Thu, 31
 Mar 2022 00:24:51 +0200
Message-ID: <bcb7b671-6c82-1914-7442-a96fcc460b71@gmx.com>
Date:   Thu, 31 Mar 2022 06:24:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220324160628.1572613-1-hch@lst.de>
 <20220324160628.1572613-2-hch@lst.de> <20220330144358.GF2237@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: fix direct I/O read repair for split bios
In-Reply-To: <20220330144358.GF2237@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WMMA6PQyE3Ds44+aLuOf7S9nri7MW1nG94fyzl892K74qy+tStp
 32xomkUa9xP7Y8m9AofLAZ/UfHaIqeow+fFKmF69jwM+GvpmuCr2x37iqR0CzyGuMoaCsKw
 bUyjm7xDcrepJ6XJ0beJfg8KXkzBP9VnoB1frPnR0SilUQGjfhRDTkeQTxRYRw7kphDYcry
 ypv+jFNhAH2FmK0Kw11Hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Nnfg8DV/6I=:QiWohr+iXJOAg3YulgyONq
 ffUvr/TjaQJZ3oaA4d34GY9pG/Wi17kGzliBoRC7ktb3abfFrccuIfEY7rcjO2KuMHFdDnLUI
 f91LOi84RLcVT5P+l71/Cv0PHr4Sx3TWVNaPDbH3MROiXaSW+O4KKG7DiBq0Q2lMgN4P58DU0
 J3F+LBDVtmk2wVRG7m1cK9OJMV0u8bPUIbx5Vhg+nfu/CGTBOjPAFJHS0YZLl79KOlaYt7ZnO
 90SGYV+ZoUWdjkVf/fmHdgyZl5Gf4mqpt4lOZRIpeKGntzmH1Vv1wrUIWowUsZQA5vUw1ROlL
 gzlTZT2d1oQZ5LccNUsLbE+sSIpkBO4lCRmxtRbELAHg2hpymlyQ7rPbvX2/ibmx4TYKFmQMg
 xYxKnG7gvaUC/0GiK7krzYlQ/t1MAy9g20hdzQEOfLpXf0SIsLhyxkvu3fHJdHZFcFpOFC6QE
 dgrwBJ+h/wceL+rFMQk5dmX3kKwaHSH5I5hLvDXRy3WHxbMMHXwak1qqFyCIF6fuCmGuE9+rA
 Qc3/C4h3hzeQeN7Asy6NlV9wuFUXsL32rCwogaZCLls0D9MDJAB/+u11vHRhDZBmHuk8+CRzB
 NpREPSR92DhxvNGvVLb4EkKq2RKGnRZijMgejvmU6vd1rGxv25gT26SnV76gr6Z8BzAZHrFU9
 uL5Z+jH4364vUJ2FKi22cmbScKrtI/DaBiq8f8NC/+PADy1etoPfRo4302HnFfQCgEIaN8hny
 YatvRfIohWr6xGDQHrDCo3IgTQer/GiK/XIq36plKiIrB+reZe1LQTXMaQ2MDoO5sjk3zkXDv
 FgNOAap/5wtbwFz+8pa4le2tCJYgVng9xOqJ7F+4iMnC7I1PZxUQb4/zlWYuqX7V2NZKsKS7g
 GPSYlFfGvXbnlTiAm2duCiqKIGcaezuY9QQpoXf3IJ27aZ1G6urScrZdBIxw2NfzwW0zA0tt1
 9+/bVqMPUg/idCruhfLt+ZsMfNGVxV2TpbdYEJKKzK3GGC4WD9/JxcM6wwaN0xS7yJOAcjwf/
 7rQPVfrYUl4XXsSuUsA5nGcdMYt7QNDUs/wyubUrdNTbcTXcNfOgsEH13pK/3dVxBEfYoD+40
 2147yeXJUcX5ds=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/30 22:43, David Sterba wrote:
> On Thu, Mar 24, 2022 at 05:06:27PM +0100, Christoph Hellwig wrote:
>> When a bio is split in btrfs_submit_direct, dip->file_offset contains
>> the file offset for the first bio.  But this means the start value used
>> in btrfs_check_read_dio_bio is incorrect for subsequent bios.  Add
>> a file_offset field to struct btrfs_bio to pass along the correct offse=
t.
>>
>> Given that check_data_csum only uses start of an error message this
>> means problems with this miscalculation will only show up when I/O
>> fails or checksums mismatch.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Qu, you've removed the same logic in f4f39fc5dc30 ("btrfs: remove
> btrfs_bio::logical member") where it was a different name for the same
> variable. What changed in the logic that we don't need to store it along
> the btrfs_bio and that btrfs_dio_private can't provide anymore?

All my fault, I didn't realize that in btrfs_submit_direct() what we
really do is splitting the iomap bio.

Thus we still need that @logical member as dip is only allocated for the
whole iomap bio, not for each split btrfs bio.

Thus we need the fixes: tag.

>
> I'm a bit worried about your changes that remove/rewrite code, silently
> introducing bugs so it has to be reinstated. We don't have enough
> review coverage and in the amount of patches you send I'm increasingly
> worried how many bugs I've inadvertently let in.

Normally it should be caught by test cases. But test case coverage is
not that better than our review coverage, especially for read repair, as
it's a btrfs specific feature, and almost impossible to do stress tests.

The good news is, for most of my subpage related rewrite, the existing
test cases are pretty good catching the bugs.


I don't really have better way other than adding regression tests cases
until we found some regression.

Thanks,
Qu
