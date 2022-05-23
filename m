Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC205306C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 May 2022 02:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiEWAHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 20:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiEWAHP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 20:07:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20275387BF
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653264426;
        bh=2Y4OqFs3kgz3888RpHnxrTThkyqO6ooU1mmZF0uPTdw=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=QVHUilkvslAg1+IAUX1zLv3q5uf/1HjWtqa2O5kou/Fzdo1BQKkEQEm3oExlpMh8w
         Tt7pYY372zPpbys7pdQ3Ji4t5t80/qzo76mfvmz5x7vPbt7rKBujXcwUFRqIon1wAe
         +ZAyujXyeua1xIJkxuKiUwDgd34B5jYfDrfZBNAU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zFj-1no4IE1act-014y3t; Mon, 23
 May 2022 02:07:06 +0200
Message-ID: <8a6fb996-64c3-63b3-7f9c-aec78e83504e@gmx.com>
Date:   Mon, 23 May 2022 08:07:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220522114754.173685-1-hch@lst.de>
 <20220522114754.173685-9-hch@lst.de>
 <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com>
 <20220522123108.GA23355@lst.de>
 <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com>
 <20220522125337.GB24032@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
In-Reply-To: <20220522125337.GB24032@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1LthsXekBuqm1+Pv9Z/RXlkaq+n4pfmBLk7L+PID1iKZV8Y46W4
 Sc4GVY2YZ3EHjvJ3AR5AfHz0sIEJLlYOwBq14g4WaLhBsQ9shYzwrNwlnjrNvNZEc3ujbZS
 ssWQKXVphZXsG78Mb7Gzws1NgvAwMsFALEW3l/W3M5hWVFcYUZFubc4Rorn5E3x5ouiS3AB
 hB8DAlXJPlkFfy/bO5Q0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bD2Oe4EUJ2A=:K68jJFfS0K3TtlxvRzoK5L
 tzVHDK4A6vjKJPlecHet2Y+LwTOQHShq+hlDn8lC35ruGImvVN1h3MKFNouZkn+BiIS7M7eSD
 maheaMMHaigxqpOhSXnmh3s5vfNOxyLMD0fhQKDzaROIpYUi7MVRrx+kOZL7+Nm2erg0uTF8n
 oK1n/vcoZr8/47ut/pjzkAPp4WDJPRZ3c6PlH4UudRiGBthbGXi6gUlwi8zUEKtrBJ3NdZuZm
 7OXcSElcioZyuXcQO4j8Yz4wU36R0XFV6n+Deqn44jzhBpLaXhyO/tjp+F0/OF1ZXLIIvFhy0
 l8PV9NweXThDzChUhdvJxawXd5xSQ1Wl1LVMRv/wkVzZNai2VqNGxLj3LBSgtJpds680YzXuu
 eXNzJYPjNC7GSH5bvpbth4b/3lYDVYJrDkpYADX6q9Z4Zg4BUypMMhLJDw3ymIlsLAADHE7Nv
 VE9J/+SkA1TcKXaiw+/CQVDjzPhTN0ezWW4SPnP21VyLLpXYsDVgjOE+KIr7eNC4vtJtELalW
 MghPz8Co3Q294mM+g62PlD4bZHlCeWtMcdOyYd9I6m/z+G/1hUHyLuAnHl/0X2orcOQrq4b1W
 aaUsh6bleb4QGvihZ3u91hMVzbZVjvJxpB870jpa4aeRlk8z/jgsaYvIdWQ3Q5Qg0/DnotmPp
 1Jv2vBZquGlJatoM7061vLUW1TKfOl/sU7P4wIae0mXT6tgztdoAo3MFxw9MijGC6AQ7CH2jA
 zerE+WHgYMLdCqpNgY1sh/SqDBRpzBPUzuvsgSh1cI8PEO9YFI18ih4VDECMeuRtFshC232e0
 9FDJ0zz+Y7M3zRGviY6ddSpEPA8K1hWGmdEBwf5SeUGq8MlBegbUGY3rKyqG8BS5RUJ19asHr
 xvU/bt9yUAxxCkZfr7BgH+xBV5g2XEJK/vWujuF/mmruYjK1QjzDiQrBwS0MI8Q4s/E4N3tbz
 ZImHmxiYaecKln4hogRhEhqAzJflgI4vmqIB6VxcMc7jqyCRqUhh0g8CZxSah4mD0j89pm8i9
 JOpIJGbtAPL6QblGbaighh696BB3xongazUm0vRmhm/S1zUdHb4oSh+06//TtEJrUKP6m4pxs
 k2nLN3WLEif5AVvF8dDfgDPSyUi5R+/GCCS5ZZpSsLRYN/c/MMVBmnftQ==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/22 20:53, Christoph Hellwig wrote:
> On Sun, May 22, 2022 at 08:38:50PM +0800, Qu Wenruo wrote:
>>> 'cause now a lot of the bio works will depend on the read repair, and
>>> I don't want to block it on yet another series..
>>
>> Although I believe we will have to take more time on the read repair
>> code/functionality.
>>
>> Especially all our submitted version have their own problems.
>>
>>  From the basic handling of checker pattern corruption, to the trade-of=
f
>> between memory allocation and performance for read on corrupted data.
>
> I've already pushed out a new version here:
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-re=
ad_repair
>
> so feel free to take a look.  I just don't want to spam the list with it
> quite yet with this series outstanding.

I checked the code, but still find the code in patch "btrfs: add new
read repair infrastructure" not that instinctive.

- Why we bother different repair methods in btrfs_repair_one_mirror()?
   In fact btrfs_repair_io_failure() can handle all profiles.

   Then why we go back to write the whole bio?
   The only reason I can think of is, we're still trying to do some
   "optimization".

   But all our bio submission is already synchronous, I doubt such
   "optimization" would make much difference.

- The bio truncation
   This really looks like a bandage to address the checker pattern
   corruption.
   I doubt why not just do per-sector read/write like:

+	/* Init read bio to contain that corrupted sector only */
+	for (i =3D get_next_mirror(init_mirror); i !=3D init_mirror; i++) {
+		int ret;
+
+		ret =3D btrfs_map_bio_wait(inode, read_bio, i);
+		/* Failed to submit, try next mirror */
+		if (ret < 0)
+			continue;
+
+		/* Verify the checksum */
+		if (failed_bbio->csum)
+			ret =3D btrfs_check_data_sector(fs_info, page,
+					pgoff, repair_bbio->csum);
+		if (ret =3D=3D 0) {
+			found_good =3D true;
+			btrfs_repair_io_failure();
+			break;
+		}
+	}
+	if (!found_good)
+		return -EIO;

To me, the "optimization" of batched read/write is only relevant if we
have tons of corrupted sectors in a read bio, which I don't believe is a
hot path in real world anyway.

Thanks,
Qu
