Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666E159194C
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiHMHoG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMHoF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 03:44:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4371B87F
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 00:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660376634;
        bh=ooHbZEOr0g3u1bkr34y33tb6QrsquLfPosDIfvyXG4M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XZEUYbGAIc1lJRH0UddaaGCuWt3wiB9gXlRAOIAzyTsbBeyh9cBAHoVfbQEd0eDp+
         C9vzA3qCYPEI7oIhr/tENmZegdQoKN3p5uuctUhx/WL/hsJOCU6nRfbZtkvuTjqpL8
         DWlPHuxUqaPZopsB8+SQ2VfdBehf3coRn3CLpMsE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1nlmQw23Ed-00bK6n; Sat, 13
 Aug 2022 09:43:54 +0200
Message-ID: <1f71de8a-2292-054e-913b-15e41b409de6@gmx.com>
Date:   Sat, 13 Aug 2022 15:43:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] btrfs: don't merge pages into bio if their page offset is
 not continuous
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <8641e5e791942d86de0a1b3ee120570441616fdc.1660375698.git.wqu@suse.com>
 <20220813073909.GA11586@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220813073909.GA11586@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lOcyy8Tvaj0mPl2WtqHLQ0eOuuiy8GR0gB3JaLrFWBHn0SPQ0UG
 RzzAMyxbjxAu1rzKqirPDcAsMeqCx0goP9B0cOYyMf69Ws5aoCfu58hTYNwN6kW/Rmpd+5h
 hsHnPJWKVxYbYxMXk5c7KpHvP24g4IgYg1Q9bEVInlE6qTsXNF/lsDzQJhsZRogIePVV9YZ
 ia1jF3LrhyRBsufHDt5ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rTfIKLxpRLU=:z9geVLIY0PJEQhQwhtvrvX
 bqpIt9G2pRE4Yxmz3S2F2QeZxKLaT8cubvwqw9uh2e36Paq/70+zAuFq07jKSSMlZ7irb0S7N
 imSYAssoLRNgfM5iP6oMhFw5P7ygQu3cXhepkJWthljzBAoN6hZ40/XxJWs+wBpn4EW1CkvI8
 WMF7SlHN3i1rdwmK7G7XsUCPgnLLHVUCT7tQGjH5Dlc4Eg/G+rCaAn7z3SxOiVsDEYelZEOfJ
 EF8gxBdBfnmowtXeFejdAy2fY3ivxmLI9XhatZ/J5+3nSFcV7BNDEFiCOAI9vX3TEYhlnNOwQ
 vPtKeRf9Cwp4U2rgSazL8s83vghtCKKMymgqc1GhJQd2IVWtu2dPdZN+UC0Fd9yJoNqItn/+s
 dTKwIeoWqdqZVgeOFMaPc8215JLPJqK7T7BlxAW8wmRb2rwCGpmS8JhIp7n6HaIqBapOYmkxw
 BrvlHy56iaA7nLRR8v43veH4/m0c3EJwJNV3CnVhAH+o9VSyJPv0B+6f4/Xlmi0yiMZJU3aCJ
 BVFUJI9sfCf0dl3bkP0WFBOeZDY0OHFX120rWXxQaPpyHqR/HOFPLla8x0zq0b5Xcf+IBmPyN
 uMIVBTlYulgoP2THJEiLUW14iUCQ5U1MMXKIlXMQyNeQFhAbWvUQ41o1l24ls1lHt9nQ6vaed
 a9SXLnmgBF0AKpb/rxafrwqzUI6VsY7nH1pWqjKITlyUG+83r6r/1O1mgtdDMwVyp4RxC4fSm
 KjU2TQLE2xDWlqLl50RU6LMfbKJgeyBQLCdVyVQVVI5dsqI2aNFXUIlkHV+dRy9Gcgp4lz6Hd
 sept10Rwz2sX+qeJatqTJv4TL7UihEuOI+YUepfToC3MKdcJxC9gi/yuoSp6a95/9i9Q5ZekG
 EPajsp12rigHW39/PYDg+hQHqI0EHdA+gDuNLPvJs0y7hEWjxpBYb7+KH4i7+S1z8SHI7a/nf
 AvTd0Zk/OSHa6cFD45LENmNfk22f/nl3o2qwxM8e5PyPiGVYWoL46rABAIpC5b5wx9/axgvwe
 Lpk3ru4NwdKkaRJxqZAeEk6f6EmlS4Yd4pyYdygD4Dh7kZgIED6DbOGpASkOCLgytrMEE1L0o
 3VHYIBZShClmIQPdY+4C3sAUuosLkyMsVEHsUnZ4wxgtPefnpApc/c6og==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/13 15:39, Christoph Hellwig wrote:
>> +	if (bio_ctrl->compress_type !=3D BTRFS_COMPRESS_NONE) {
>>   		contig =3D bio->bi_iter.bi_sector =3D=3D sector;
>> -	else
>> -		contig =3D bio_end_sector(bio) =3D=3D sector;
>> +	} else {
>
> I don't tink we can lose the bio_end_sector check here.
>
> Also if you touch this, invrting the check so that it is
>
> 	if (bio_ctrl->compress_type =3D=3D BTRFS_COMPRESS_NONE) {
> 		/* main version here */
> 	} else {
> 		/* compressed special case */
> 	}
>
> might make it a bit readable.

Indeed.

>
>> +		struct bio_vec *bvec;
>> +
>> +		/* Empty bio, we can always add page into it. */
>> +		if (bio->bi_iter.bi_size =3D=3D 0) {
>
> This is also true for the compressed case, isn't it?

That is already implied in the "contig =3D bio->bi_iter.bi_sector =3D=3D
sector;" check.

Remember for compressed IO, we always set the the disk_bytenr to
whatever the bytenr of the extent start.

>
> So maybe:
>
> 	if (bio->bi_iter.bi_size =3D=3D 0) {
> 		contig =3D true;
> 	} else if (bio_ctrl->compress_type =3D=3D BTRFS_COMPRESS_NONE) {
> 		struct bio_vec *bvec =3D bio_last_bvec_all(bio);
>
> 		/*
> 		 * The contig check requires the following conditions to be met:
> 		 * 1) The pages are belonging to the same inode
> 		 * 2) The range has adjacent logical bytenr
> 		 * 3) The range has adjacent file offset (NEW)
> 		 *    This is required for the usage of btrfs_bio->file_offset.
> 		 */
> 		contig =3D bio_end_sector(bio) =3D=3D sector &&
> 			    page_offset(bvec->bv_page) + bvec->bv_offset +
> 			    bvec->bv_len =3D=3D page_offset(page) + pg_offset);
> 	} else {
> 		contig =3D bio->bi_iter.bi_sector =3D=3D sector;
> 	}

This indeed looks better.

>
> (we don't need the mapping check, as all the submit_extent_page
> always loops over the same mapping)

Yep, that mapping check is already implied by the call chain.

BTW, I'll also update the commit message to mention some future
cleanups, as now a btrfs_bio is completely a continous range, thus
things like endio_readpage_release_extent() related infrastructure can
also be removed.

Thanks,
Qu
