Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15434B362
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 09:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfFSHvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 03:51:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfFSHvR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 03:51:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C788DAF51
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 07:51:15 +0000 (UTC)
Subject: Re: [PATCH 5/6] btrfs: use raid_attr for minimum stripe count in
 btrfs_calc_avail_data_space
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1560880630.git.dsterba@suse.com>
 <ffdc7e77015c2f5ad45de7acc2336fe2901bb605.1560880630.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 mQINBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABtCNOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuY29tPokCOAQTAQIAIgUCWIo48QIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQcb6CRuU/KFc0eg/9GLD3wTQz9iZHMFbjiqTCitD7B6dTLV1C
 ddZVlC8Hm/TophPts1bWZORAmYIihHHI1EIF19+bfIr46pvfTu0yFrJDLOADMDH+Ufzsfy2v
 HSqqWV/nOSWGXzh8bgg/ncLwrIdEwBQBN9SDS6aqsglagvwFD91UCg/TshLlRxD5BOnuzfzI
 Leyx2c6YmH7Oa1R4MX9Jo79SaKwdHt2yRN3SochVtxCyafDlZsE/efp21pMiaK1HoCOZTBp5
 VzrIP85GATh18pN7YR9CuPxxN0V6IzT7IlhS4Jgj0NXh6vi1DlmKspr+FOevu4RVXqqcNTSS
 E2rycB2v6cttH21UUdu/0FtMBKh+rv8+yD49FxMYnTi1jwVzr208vDdRU2v7Ij/TxYt/v4O8
 V+jNRKy5Fevca/1xroQBICXsNoFLr10X5IjmhAhqIH8Atpz/89ItS3+HWuE4BHB6RRLM0gy8
 T7rN6ja+KegOGikp/VTwBlszhvfLhyoyjXI44Tf3oLSFM+8+qG3B7MNBHOt60CQlMkq0fGXd
 mm4xENl/SSeHsiomdveeq7cNGpHi6i6ntZK33XJLwvyf00PD7tip/GUj0Dic/ZUsoPSTF/mG
 EpuQiUZs8X2xjK/AS/l3wa4Kz2tlcOKSKpIpna7V1+CMNkNzaCOlbv7QwprAerKYywPCoOSC
 7P25Ag0EWIoHPgEQAMiUqvRBZNvPvki34O/dcTodvLSyOmK/MMBDrzN8Cnk302XfnGlW/YAQ
 csMWISKKSpStc6tmD+2Y0z9WjyRqFr3EGfH1RXSv9Z1vmfPzU42jsdZn667UxrRcVQXUgoKg
 QYx055Q2FdUeaZSaivoIBD9WtJq/66UPXRRr4H/+Y5FaUZx+gWNGmBT6a0S/GQnHb9g3nonD
 jmDKGw+YO4P6aEMxyy3k9PstaoiyBXnzQASzdOi39BgWQuZfIQjN0aW+Dm8kOAfT5i/yk59h
 VV6v3NLHBjHVw9kHli3jwvsizIX9X2W8tb1SefaVxqvqO1132AO8V9CbE1DcVT8fzICvGi42
 FoV/k0QOGwq+LmLf0t04Q0csEl+h69ZcqeBSQcIMm/Ir+NorfCr6HjrB6lW7giBkQl6hhomn
 l1mtDP6MTdbyYzEiBFcwQD4terc7S/8ELRRybWQHQp7sxQM/Lnuhs77MgY/e6c5AVWnMKd/z
 MKm4ru7A8+8gdHeydrRQSWDaVbfy3Hup0Ia76J9FaolnjB8YLUOJPdhI2vbvNCQ2ipxw3Y3c
 KhVIpGYqwdvFIiz0Fej7wnJICIrpJs/+XLQHyqcmERn3s/iWwBpeogrx2Lf8AGezqnv9woq7
 OSoWlwXDJiUdaqPEB/HmGfqoRRN20jx+OOvuaBMPAPb+aKJyle8zABEBAAGJAh8EGAECAAkF
 AliKBz4CGwwACgkQcb6CRuU/KFdacg/+M3V3Ti9JYZEiIyVhqs+yHb6NMI1R0kkAmzsGQ1jU
 zSQUz9AVMR6T7v2fIETTT/f5Oout0+Hi9cY8uLpk8CWno9V9eR/B7Ifs2pAA8lh2nW43FFwp
 IDiSuDbH6oTLmiGCB206IvSuaQCp1fed8U6yuqGFcnf0ZpJm/sILG2ECdFK9RYnMIaeqlNQm
 iZicBY2lmlYFBEaMXHoy+K7nbOuizPWdUKoKHq+tmZ3iA+qL5s6Qlm4trH28/fPpFuOmgP8P
 K+7LpYLNSl1oQUr+WlqilPAuLcCo5Vdl7M7VFLMq4xxY/dY99aZx0ZJQYFx0w/6UkbDdFLzN
 upT7NIN68lZRucImffiWyN7CjH23X3Tni8bS9ubo7OON68NbPz1YIaYaHmnVQCjDyDXkQoKC
 R82Vf9mf5slj0Vlpf+/Wpsv/TH8X32ajva37oEQTkWNMsDxyw3aPSps6MaMafcN7k60y2Wk/
 TCiLsRHFfMHFY6/lq/c0ZdOsGjgpIK0G0z6et9YU6MaPuKwNY4kBdjPNBwHreucrQVUdqRRm
 RcxmGC6ohvpqVGfhT48ZPZKZEWM+tZky0mO7bhZYxMXyVjBn4EoNTsXy1et9Y1dU3HVJ8fod
 5UqrNrzIQFbdeM0/JqSLrtlTcXKJ7cYFa9ZM2AP7UIN9n1UWxq+OPY9YMOewVfYtL8M=
Message-ID: <7adb54d3-38c9-738b-caf0-c6926ab19dbb@suse.com>
Date:   Wed, 19 Jun 2019 10:51:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ffdc7e77015c2f5ad45de7acc2336fe2901bb605.1560880630.git.dsterba@suse.com>
Content-Type: multipart/mixed;
 boundary="------------55EC816817FB124BA7941F91"
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------55EC816817FB124BA7941F91
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 18.06.19 г. 21:00 ч., David Sterba wrote:
> Minimum stripe count matches the minimum devices required for a given
> profile. The open coded assignments match the raid_attr table.
> 
> What's changed here is the meaning for RAID5/6. Previously their
> min_stripes would be 1, while newly it's devs_min. This however shold be
> the same as before because it's not possible to create filesystem on
> fewer devices than the raid_attr table allows.
> 
> There's no adjustment regarding the parity stripes (like
> calc_data_stripes does), because we're interested in overall space that
> would fit on the devices.
> 
> Missing devices make no difference for the whole calculation, we have
> the size stored in the structures.

I think the clean up in this function should include more here's list of
things which I think will make it more readable. Something like the
attached diff on top of your patch:



--------------55EC816817FB124BA7941F91
Content-Type: text/x-patch;
 name="calc-avail-space.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="calc-avail-space.diff"

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6e196b8a0820..230aef8314da 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1898,11 +1898,10 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 	struct btrfs_device_info *devices_info;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
-	u64 skip_space;
 	u64 type;
 	u64 avail_space;
 	u64 min_stripe_size;
-	int min_stripes = 1, num_stripes = 1;
+	int num_stripes = 1;
 	int i = 0, nr_devices;
 
 	/*
@@ -1957,28 +1956,21 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 		avail_space = device->total_bytes - device->bytes_used;
 
 		/* align with stripe_len */
-		avail_space = div_u64(avail_space, BTRFS_STRIPE_LEN);
-		avail_space *= BTRFS_STRIPE_LEN;
+		avail_space = rounddown(avail_space, BTRFS_STRIPE_LEN);
 
 		/*
 		 * In order to avoid overwriting the superblock on the drive,
 		 * btrfs starts at an offset of at least 1MB when doing chunk
 		 * allocation.
+		 *
+		 * This ensures we have at least min_stripe_size free space
+		 * after excluding 1mb.
 		 */
-		skip_space = SZ_1M;
-
-		/*
-		 * we can use the free space in [0, skip_space - 1], subtract
-		 * it from the total.
-		 */
-		if (avail_space && avail_space >= skip_space)
-			avail_space -= skip_space;
-		else
-			avail_space = 0;
-
-		if (avail_space < min_stripe_size)
+		if (avail_space <= SZ_1M + min_stripe_size)
 			continue;
 
+		avail_space -= SZ_1M;
+
 		devices_info[i].dev = device;
 		devices_info[i].max_avail = avail_space;
 
@@ -1992,9 +1984,8 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 
 	i = nr_devices - 1;
 	avail_space = 0;
-	while (nr_devices >= min_stripes) {
-		if (num_stripes > nr_devices)
-			num_stripes = nr_devices;
+	while (nr_devices >= rattr->devs_min) {
+		num_stripes = min(num_stripes, nr_devices);
 
 		if (devices_info[i].max_avail >= min_stripe_size) {
 			int j;

--------------55EC816817FB124BA7941F91--
