Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EECA1D0543
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 05:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgEMDKq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 23:10:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:42371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEMDKq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 23:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589339433;
        bh=LI76RMI23gAkYHr4nZrFlDXjf6/AxLLLUX0Z7JVlGwQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gbhEw1O552lO1q4PeLgdjcJs4/Pg3uiLQMwknXFD3BfZR6OgGQGwaRPAKSzLVt27n
         Hym6JIuYWgt3Zcdn4isYcZicBmk3NwO+oNWsGdv/97b6wOdwhY3uLbUf4VbfNIu8IC
         qTERGRyTs1NLLlFtGwbrCNexF4dq44A+oCasYLNg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59C8-1jZnie2A7w-001DGg; Wed, 13
 May 2020 05:10:33 +0200
Subject: Re: Bug 5.7-rc: write-time leaf corruption detected
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <FdManana@suse.com>
References: <29b671353fff0d745e2e99d420585c1f25fab107dd63b8e1a812c384875575b8.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <bc41c365-56db-046c-c41f-e39a205e2012@gmx.com>
Date:   Wed, 13 May 2020 11:10:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <29b671353fff0d745e2e99d420585c1f25fab107dd63b8e1a812c384875575b8.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PNxDAfg2xoe5ejZqZsVpiVmMdsbmAyzAN"
X-Provags-ID: V03:K1:KpHX7/Zum2mMG9r65OzeAzlKzKL+YlVMUeANnMWe32dzg8vKfvu
 KKZddWqCYsDXlJt4+H6IGiFbm39udSMLk8uHIskdHjne1VJFj5wbvyT+zuvsbSjn9PNp4y+
 AeShNakT1DcDqOS3IZTmfUhdk+e5drnRRzJHIbEDxPKF3eXfPaKG2KC8A8oTvzjZ21rOh7O
 N4/mQS0jzqXiVAkGkcD+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TX3/U+RUIAo=:nPr2hDQdaWGMSEVaYsoYtm
 wXJJaHXRmi5rrb9Gj7V7Hkb3qSXt+c6oO+f5Dt+HFU01jPLte2CkLPSJY88ragHUSIJuURVJq
 DvRi2z8P9pOk3to+45lV9k+/KwfuZhpN0SBb9uBBU7rspDlxW1QPhB504+2dU/3Uw0h5OSjN2
 5wPC3gztXdu9qwSqqr2TCpKGhR7jSefd1qzalAgTBAmvMllyJ6Lo0jLgl8oQ9ABhVP98WWaBY
 4EYRGQbJbZ5LuLm4uLHaQ/PcxWWDkcBg1qhuzLRCYScDEL3cfH9J9z1ErwX+EaN3+CgnJfLQS
 HgKfKsP4GUz05gGbe40ABe8gTk7qOd0doQVVD7poC5v8EGMcvGUmbsX64plxu6xt9negv/0Lt
 vtH/ZewsgbZ7zcIz6SdpdqIQqnQZc8g4HEBv8hSLj9Fisq/BYI9LRk6Xj/ebBpmoGhQlB/FD7
 v7Z56wv5v+jvtyF3BEnLf8+oA1hoDWHeswJV0VhTEGxRXS/Ue6JhPIKQ2yMhUljTajIdJxwu1
 ohBCg+/cEtlbyCjUPexMa9Aa2vLCwonK0Y5PJLCJFTnPaccmbUPAkgOF0xYgd49Q+QkiA/7UG
 4atj36giyMkhgFnmUI0ZarFKapwjTgPyv2DAQquMKWHtlKc3a2ioTZavsTc9V2TpyQK64CoQU
 Q5jPVPz1ApkVg4z35V9kavNeSbK8MFQp5FeugUbtyoCt6e8+KyqOPZLkvvdBLzQhFuBOYSBsg
 7AtKD1V0M//4Wcaz5hsp+DePA8DNKg5u22R2I2tw1p3ZYlmHE6tRoqnXjMqILSZLGhG7rljqJ
 oB4+BDzBuwR8PykWAs5pwuatE54fpdh82CAWBk8C/Zi00tzvMEEw4FEbCIB4zv31wAmrK+ZD+
 oxMzJjhRnVJvDKh6lhBJlahXXxYkhVyRmVFMk1vNKCNIQ6TcFcyRRy08FMHFVRw18U2DGnMp2
 qBwWD3FiiRSJMC8lmVBdVbttJ9z8G1z0VrNbSyCKDWaPo1glaPzumH11kzfgkwM4qRovSjqJv
 KyCgnTFNlpf33/zGtIg9Pq5eUOegKJdv4CoX0D5AXw9Virvat7siAPasG5u3xmOuHjE6e97pe
 Ve2eiUo3snou33KNrPhXtG3X3AOTwJMK1HQuGwSVsDEDwwNFdz9HUur9wWKS/b7IzkeQDL+rC
 GBP2VXquz0/QCAWNY18+p3EOvytw6VROTynD4pJI72wNP9A32ITPRoZ4R8hY9EJLK/ZtVlMnu
 a+4M82LPf4jZKNvkk
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PNxDAfg2xoe5ejZqZsVpiVmMdsbmAyzAN
Content-Type: multipart/mixed; boundary="vWWMwPJwVPZiwdSsEMcA6lppf3jbE27Wx"

--vWWMwPJwVPZiwdSsEMcA6lppf3jbE27Wx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/12 =E4=B8=8B=E5=8D=8810:15, David Sterba wrote:
> Happened once in a VM, defaul mkfs/mount options.

It looks like it's pretty hard to reproduce.

>=20
> generic/457		[05:40:52][17606.984360] run fstests generic/457 at 2020-0=
5-04 05:40:52
> [17607.625840] BTRFS: device fsid ae51523a-71e7-4730-9097-faeca36779be =
devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (27036)
> [17607.664903] BTRFS info (device vdb): disk space caching is enabled
> [17607.667422] BTRFS info (device vdb): has skinny extents
> [17607.669552] BTRFS info (device vdb): flagging fs with big metadata f=
eature
> [17607.681613] BTRFS info (device vdb): checking UUID tree
> [17607.921588] BTRFS: device fsid 16238d8a-1af3-4fa1-b3bc-fd6f04469192 =
devid 1 transid 5 /dev/mapper/logwrites-test scanned by mkfs.btrfs (27101=
)
> [17607.948085] BTRFS info (device dm-0): turning on sync discard
> [17607.952647] BTRFS info (device dm-0): disk space caching is enabled
> [17607.955088] BTRFS info (device dm-0): has skinny extents
> [17607.956924] BTRFS info (device dm-0): flagging fs with big metadata =
feature
> [17607.966128] BTRFS info (device dm-0): checking UUID tree
> [17608.092098] BTRFS critical (device dm-0): corrupt leaf: root=3D18446=
744073709551610 block=3D30949376 slot=3D104, csum end range (13807616) go=
es beyond the start range (13717504) of the next csum item
> [17608.098129] BTRFS info (device dm-0): leaf 30949376 gen 6 total ptrs=
 121 free space 6325 owner 18446744073709551610
> [17608.102727] BTRFS info (device dm-0): refs 2 lock (w:0 r:0 bw:0 br:0=
 sw:0 sr:0) lock_owner 0 current 27162
> [17608.106426] 	item 0 key (257 1 0) itemoff 16123 itemsize 160

Since we have 257 INODE_ITEM here, I guess that's all the log tree have.

And surprisingly, the csum range around 1371000 doesn't even get
referred in this log tree.

Filipe, any idea on how this could happen?

Thanks,
Qu
> [17608.108766] 		inode generation 6 size 262144 mode 100600
> [17608.110947] 	item 1 key (257 12 256) itemoff 16103 itemsize 20
> [17608.112698] 	item 2 key (257 108 0) itemoff 16050 itemsize 53
> [17608.114568] 		extent data disk bytenr 13631488 nr 262144
> [17608.116352] 		extent data offset 0 nr 262144 ram 262144
> [17608.118082] 	item 3 key (258 1 0) itemoff 15890 itemsize 160
> [17608.119920] 		inode generation 6 size 262144 mode 100600
> [17608.121605] 	item 4 key (258 12 256) itemoff 15871 itemsize 19
> [17608.123293] 	item 5 key (258 108 0) itemoff 15818 itemsize 53
> [17608.125212] 		extent data disk bytenr 13905920 nr 4096
> [17608.126851] 		extent data offset 0 nr 4096 ram 4096
> [17608.128342] 	item 6 key (258 108 4096) itemoff 15765 itemsize 53
> [17608.130106] 		extent data disk bytenr 13631488 nr 262144
> [17608.131774] 		extent data offset 0 nr 4096 ram 262144
> [17608.133330] 	item 7 key (258 108 8192) itemoff 15712 itemsize 53
> [17608.135151] 		extent data disk bytenr 13631488 nr 262144
> [17608.136680] 		extent data offset 8192 nr 8192 ram 262144
> [17608.137931] 	item 8 key (258 108 16384) itemoff 15659 itemsize 53
> [17608.139257] 		extent data disk bytenr 13631488 nr 262144
> [17608.140939] 		extent data offset 204800 nr 16384 ram 262144
> [17608.142255] 	item 9 key (258 108 32768) itemoff 15606 itemsize 53
> [17608.143941] 		extent data disk bytenr 13910016 nr 28672
> [17608.145576] 		extent data offset 0 nr 28672 ram 28672
> [17608.147165] 	item 10 key (258 108 61440) itemoff 15553 itemsize 53
> [17608.148964] 		extent data disk bytenr 13631488 nr 262144
> [17608.150563] 		extent data offset 249856 nr 8192 ram 262144
> [17608.152204] 	item 11 key (258 108 69632) itemoff 15500 itemsize 53
> [17608.153974] 		extent data disk bytenr 13631488 nr 262144
> [17608.155588] 		extent data offset 69632 nr 126976 ram 262144
> [17608.157099] 	item 12 key (258 108 196608) itemoff 15447 itemsize 53
> [17608.158698] 		extent data disk bytenr 13938688 nr 4096
> [17608.160123] 		extent data offset 0 nr 4096 ram 4096
> [17608.161300] 	item 13 key (258 108 200704) itemoff 15394 itemsize 53
> [17608.162597] 		extent data disk bytenr 0 nr 0
> [17608.164057] 		extent data offset 0 nr 28672 ram 28672
> [17608.165782] 	item 14 key (258 108 229376) itemoff 15341 itemsize 53
> [17608.167691] 		extent data disk bytenr 13942784 nr 4096
> [17608.169259] 		extent data offset 0 nr 4096 ram 4096
> [17608.170821] 	item 15 key (258 108 233472) itemoff 15288 itemsize 53
> [17608.172687] 		extent data disk bytenr 13631488 nr 262144
> [17608.174310] 		extent data offset 233472 nr 12288 ram 262144
> [17608.175993] 	item 16 key (258 108 245760) itemoff 15235 itemsize 53
> [17608.177821] 		extent data disk bytenr 13946880 nr 16384
> [17608.179440] 		extent data offset 0 nr 16384 ram 16384
> [17608.181043] 	item 17 key (259 1 0) itemoff 15075 itemsize 160
> [17608.182796] 		inode generation 6 size 262144 mode 100600
> [17608.184424] 	item 18 key (259 12 256) itemoff 15056 itemsize 19
> [17608.186085] 	item 19 key (259 108 0) itemoff 15003 itemsize 53
> [17608.187859] 		extent data disk bytenr 13975552 nr 4096
> [17608.189525] 		extent data offset 0 nr 4096 ram 4096
> [17608.191074] 	item 20 key (259 108 4096) itemoff 14950 itemsize 53
> [17608.192816] 		extent data disk bytenr 13631488 nr 262144
> [17608.194464] 		extent data offset 0 nr 4096 ram 262144
> [17608.196206] 	item 21 key (259 108 8192) itemoff 14897 itemsize 53
> [17608.198212] 		extent data disk bytenr 13631488 nr 262144
> [17608.200048] 		extent data offset 8192 nr 106496 ram 262144
> [17608.201684] 	item 22 key (259 108 114688) itemoff 14844 itemsize 53
> [17608.203659] 		extent data disk bytenr 14217216 nr 49152
> [17608.205398] 		extent data offset 0 nr 49152 ram 49152
> [17608.207126] 	item 23 key (259 108 163840) itemoff 14791 itemsize 53
> [17608.209019] 		extent data disk bytenr 13631488 nr 262144
> [17608.210736] 		extent data offset 163840 nr 98304 ram 262144
> [17608.212371] 	item 24 key (261 1 0) itemoff 14631 itemsize 160
> [17608.222944] 		inode generation 6 size 262144 mode 100600
> [17608.224637] 	item 25 key (261 12 256) itemoff 14612 itemsize 19
> [17608.226400] 	item 26 key (261 108 0) itemoff 14559 itemsize 53
> [17608.228169] 		extent data disk bytenr 14123008 nr 4096
> [17608.229794] 		extent data offset 0 nr 4096 ram 4096
> [17608.231292] 	item 27 key (261 108 4096) itemoff 14506 itemsize 53
> [17608.233203] 		extent data disk bytenr 13631488 nr 262144
> [17608.234794] 		extent data offset 0 nr 4096 ram 262144
> [17608.236362] 	item 28 key (261 108 8192) itemoff 14453 itemsize 53
> [17608.238102] 		extent data disk bytenr 13631488 nr 262144
> [17608.239782] 		extent data offset 8192 nr 16384 ram 262144
> [17608.241587] 	item 29 key (261 108 24576) itemoff 14400 itemsize 53
> [17608.243431] 		extent data disk bytenr 13631488 nr 262144
> [17608.245176] 		extent data offset 212992 nr 36864 ram 262144
> [17608.246991] 	item 30 key (261 108 61440) itemoff 14347 itemsize 53
> [17608.248868] 		extent data disk bytenr 13631488 nr 262144
> [17608.250456] 		extent data offset 61440 nr 114688 ram 262144
> [17608.252333] 	item 31 key (261 108 176128) itemoff 14294 itemsize 53
> [17608.254343] 		extent data disk bytenr 14135296 nr 61440
> [17608.256131] 		extent data offset 0 nr 61440 ram 61440
> [17608.257857] 	item 32 key (261 108 237568) itemoff 14241 itemsize 53
> [17608.259864] 		extent data disk bytenr 13631488 nr 262144
> [17608.261484] 		extent data offset 237568 nr 24576 ram 262144
> [17608.263134] 	item 33 key (262 1 0) itemoff 14081 itemsize 160
> [17608.264865] 		inode generation 6 size 178311 mode 100600
> [17608.266625] 	item 34 key (262 12 256) itemoff 14062 itemsize 19
> [17608.268551] 	item 35 key (262 108 0) itemoff 14009 itemsize 53
> [17608.270363] 		extent data disk bytenr 14196736 nr 4096
> [17608.272019] 		extent data offset 0 nr 4096 ram 4096
> [17608.273505] 	item 36 key (262 108 4096) itemoff 13956 itemsize 53
> [17608.275387] 		extent data disk bytenr 13631488 nr 262144
> [17608.277125] 		extent data offset 0 nr 4096 ram 262144
> [17608.278780] 	item 37 key (262 108 8192) itemoff 13903 itemsize 53
> [17608.280507] 		extent data disk bytenr 13631488 nr 262144
> [17608.282163] 		extent data offset 8192 nr 106496 ram 262144
> [17608.283866] 	item 38 key (262 108 114688) itemoff 13850 itemsize 53
> [17608.285727] 		extent data disk bytenr 14200832 nr 4096
> [17608.287264] 		extent data offset 0 nr 4096 ram 4096
> [17608.288719] 	item 39 key (262 108 118784) itemoff 13797 itemsize 53
> [17608.290696] 		extent data disk bytenr 0 nr 0
> [17608.292237] 		extent data offset 0 nr 49152 ram 49152
> [17608.293667] 	item 40 key (262 108 167936) itemoff 13744 itemsize 53
> [17608.295436] 		extent data disk bytenr 14209024 nr 4096
> [17608.297051] 		extent data offset 0 nr 4096 ram 4096
> [17608.298583] 	item 41 key (262 108 172032) itemoff 13691 itemsize 53
> [17608.300573] 		extent data disk bytenr 13631488 nr 262144
> [17608.302323] 		extent data offset 172032 nr 8192 ram 262144
> [17608.304112] 	item 42 key (263 1 0) itemoff 13531 itemsize 160
> [17608.305810] 		inode generation 6 size 262144 mode 100600
> [17608.307444] 	item 43 key (263 12 256) itemoff 13512 itemsize 19
> [17608.309108] 	item 44 key (263 108 0) itemoff 13459 itemsize 53
> [17608.310760] 		extent data disk bytenr 14266368 nr 4096
> [17608.312269] 		extent data offset 0 nr 4096 ram 4096
> [17608.313883] 	item 45 key (263 108 4096) itemoff 13406 itemsize 53
> [17608.315659] 		extent data disk bytenr 13631488 nr 262144
> [17608.317133] 		extent data offset 0 nr 4096 ram 262144
> [17608.318691] 	item 46 key (263 108 8192) itemoff 13353 itemsize 53
> [17608.320417] 		extent data disk bytenr 13631488 nr 262144
> [17608.321851] 		extent data offset 8192 nr 81920 ram 262144
> [17608.323351] 	item 47 key (263 108 90112) itemoff 13300 itemsize 53
> [17608.325222] 		extent data disk bytenr 14319616 nr 4096
> [17608.326968] 		extent data offset 0 nr 4096 ram 4096
> [17608.328583] 	item 48 key (263 108 94208) itemoff 13247 itemsize 53
> [17608.330364] 		extent data disk bytenr 0 nr 0
> [17608.331708] 		extent data offset 0 nr 45056 ram 45056
> [17608.333200] 	item 49 key (263 108 139264) itemoff 13194 itemsize 53
> [17608.334979] 		extent data disk bytenr 14323712 nr 4096
> [17608.336570] 		extent data offset 0 nr 4096 ram 4096
> [17608.338023] 	item 50 key (263 108 143360) itemoff 13141 itemsize 53
> [17608.340091] 		extent data disk bytenr 13631488 nr 262144
> [17608.341746] 		extent data offset 143360 nr 8192 ram 262144
> [17608.343400] 	item 51 key (263 108 151552) itemoff 13088 itemsize 53
> [17608.345228] 		extent data disk bytenr 14327808 nr 61440
> [17608.346924] 		extent data offset 0 nr 61440 ram 61440
> [17608.348626] 	item 52 key (263 108 212992) itemoff 13035 itemsize 53
> [17608.350371] 		extent data disk bytenr 14270464 nr 49152
> [17608.351985] 		extent data offset 0 nr 49152 ram 49152
> [17608.353542] 	item 53 key (264 1 0) itemoff 12875 itemsize 160
> [17608.355125] 		inode generation 6 size 247974 mode 100600
> [17608.356813] 	item 54 key (264 12 256) itemoff 12856 itemsize 19
> [17608.358539] 	item 55 key (264 108 0) itemoff 12803 itemsize 53
> [17608.360340] 		extent data disk bytenr 14471168 nr 4096
> [17608.361935] 		extent data offset 0 nr 4096 ram 4096
> [17608.363426] 	item 56 key (264 108 4096) itemoff 12750 itemsize 53
> [17608.365224] 		extent data disk bytenr 13631488 nr 262144
> [17608.366836] 		extent data offset 0 nr 4096 ram 262144
> [17608.368439] 	item 57 key (264 108 8192) itemoff 12697 itemsize 53
> [17608.370226] 		extent data disk bytenr 13631488 nr 262144
> [17608.371714] 		extent data offset 8192 nr 8192 ram 262144
> [17608.373157] 	item 58 key (264 108 16384) itemoff 12644 itemsize 53
> [17608.374820] 		extent data disk bytenr 14483456 nr 4096
> [17608.376495] 		extent data offset 0 nr 4096 ram 4096
> [17608.378014] 	item 59 key (264 108 20480) itemoff 12591 itemsize 53
> [17608.379882] 		extent data disk bytenr 0 nr 0
> [17608.381425] 		extent data offset 0 nr 20480 ram 20480
> [17608.383188] 	item 60 key (264 108 40960) itemoff 12538 itemsize 53
> [17608.385037] 		extent data disk bytenr 14487552 nr 4096
> [17608.386644] 		extent data offset 0 nr 4096 ram 4096
> [17608.388191] 	item 61 key (264 108 45056) itemoff 12485 itemsize 53
> [17608.390035] 		extent data disk bytenr 13631488 nr 262144
> [17608.391634] 		extent data offset 45056 nr 20480 ram 262144
> [17608.393440] 	item 62 key (264 108 65536) itemoff 12432 itemsize 53
> [17608.395464] 		extent data disk bytenr 14475264 nr 4096
> [17608.397179] 		extent data offset 0 nr 4096 ram 4096
> [17608.398675] 	item 63 key (264 108 69632) itemoff 12379 itemsize 53
> [17608.400412] 		extent data disk bytenr 0 nr 0
> [17608.401843] 		extent data offset 0 nr 28672 ram 49152
> [17608.403409] 	item 64 key (264 108 98304) itemoff 12326 itemsize 53
> [17608.405389] 		extent data disk bytenr 14491648 nr 20480
> [17608.407111] 		extent data offset 0 nr 8192 ram 20480
> [17608.408795] 	item 65 key (264 108 106496) itemoff 12273 itemsize 53
> [17608.410757] 		extent data disk bytenr 14561280 nr 53248
> [17608.412483] 		extent data offset 0 nr 53248 ram 53248
> [17608.414166] 	item 66 key (264 108 159744) itemoff 12220 itemsize 53
> [17608.416164] 		extent data disk bytenr 13631488 nr 262144
> [17608.417897] 		extent data offset 159744 nr 16384 ram 262144
> [17608.419677] 	item 67 key (264 108 176128) itemoff 12167 itemsize 53
> [17608.421598] 		extent data disk bytenr 13631488 nr 262144
> [17608.423313] 		extent data offset 237568 nr 4096 ram 262144
> [17608.425051] 	item 68 key (264 108 180224) itemoff 12114 itemsize 53
> [17608.427009] 		extent data disk bytenr 13631488 nr 262144
> [17608.428787] 		extent data offset 180224 nr 45056 ram 262144
> [17608.430588] 	item 69 key (264 108 225280) itemoff 12061 itemsize 53
> [17608.432457] 		extent data disk bytenr 14614528 nr 16384
> [17608.434122] 		extent data offset 0 nr 16384 ram 16384
> [17608.435663] 	item 70 key (264 108 241664) itemoff 12008 itemsize 53
> [17608.437520] 		extent data disk bytenr 13631488 nr 262144
> [17608.439160] 		extent data offset 241664 nr 8192 ram 262144
> [17608.440869] 	item 71 key (265 1 0) itemoff 11848 itemsize 160
> [17608.442586] 		inode generation 6 size 193781 mode 100600
> [17608.444197] 	item 72 key (265 12 256) itemoff 11829 itemsize 19
> [17608.446043] 	item 73 key (265 108 0) itemoff 11776 itemsize 53
> [17608.447726] 		extent data disk bytenr 14524416 nr 4096
> [17608.449507] 		extent data offset 0 nr 4096 ram 4096
> [17608.451142] 	item 74 key (265 108 4096) itemoff 11723 itemsize 53
> [17608.452883] 		extent data disk bytenr 13631488 nr 262144
> [17608.454517] 		extent data offset 0 nr 4096 ram 262144
> [17608.456136] 	item 75 key (265 108 8192) itemoff 11670 itemsize 53
> [17608.458065] 		extent data disk bytenr 13631488 nr 262144
> [17608.459732] 		extent data offset 8192 nr 110592 ram 262144
> [17608.461260] 	item 76 key (265 108 118784) itemoff 11617 itemsize 53
> [17608.462918] 		extent data disk bytenr 14528512 nr 28672
> [17608.464562] 		extent data offset 0 nr 28672 ram 28672
> [17608.466204] 	item 77 key (265 108 147456) itemoff 11564 itemsize 53
> [17608.468161] 		extent data disk bytenr 0 nr 0
> [17608.469631] 		extent data offset 8192 nr 4096 ram 12288
> [17608.471331] 	item 78 key (265 108 151552) itemoff 11511 itemsize 53
> [17608.473363] 		extent data disk bytenr 14557184 nr 4096
> [17608.474920] 		extent data offset 0 nr 4096 ram 4096
> [17608.476499] 	item 79 key (265 108 155648) itemoff 11458 itemsize 53
> [17608.478306] 		extent data disk bytenr 13631488 nr 262144
> [17608.479921] 		extent data offset 155648 nr 40960 ram 262144
> [17608.481652] 	item 80 key (266 1 0) itemoff 11298 itemsize 160
> [17608.483268] 		inode generation 6 size 262144 mode 100600
> [17608.484849] 	item 81 key (266 12 256) itemoff 11279 itemsize 19
> [17608.486489] 	item 82 key (266 108 0) itemoff 11226 itemsize 53
> [17608.488298] 		extent data disk bytenr 14712832 nr 4096
> [17608.489866] 		extent data offset 0 nr 4096 ram 4096
> [17608.491399] 	item 83 key (266 108 4096) itemoff 11173 itemsize 53
> [17608.493255] 		extent data disk bytenr 13631488 nr 262144
> [17608.494898] 		extent data offset 0 nr 4096 ram 262144
> [17608.496504] 	item 84 key (266 108 8192) itemoff 11120 itemsize 53
> [17608.498434] 		extent data disk bytenr 13631488 nr 262144
> [17608.500033] 		extent data offset 8192 nr 73728 ram 262144
> [17608.501619] 	item 85 key (266 108 81920) itemoff 11067 itemsize 53
> [17608.503455] 		extent data disk bytenr 14741504 nr 4096
> [17608.505086] 		extent data offset 0 nr 4096 ram 4096
> [17608.506648] 	item 86 key (266 108 86016) itemoff 11014 itemsize 53
> [17608.508346] 		extent data disk bytenr 13631488 nr 262144
> [17608.509862] 		extent data offset 86016 nr 28672 ram 262144
> [17608.511645] 	item 87 key (266 108 114688) itemoff 10961 itemsize 53
> [17608.513620] 		extent data disk bytenr 13631488 nr 262144
> [17608.515403] 		extent data offset 36864 nr 28672 ram 262144
> [17608.517234] 	item 88 key (266 108 143360) itemoff 10908 itemsize 53
> [17608.519248] 		extent data disk bytenr 13631488 nr 262144
> [17608.520976] 		extent data offset 143360 nr 16384 ram 262144
> [17608.522635] 	item 89 key (266 108 159744) itemoff 10855 itemsize 53
> [17608.524583] 		extent data disk bytenr 14745600 nr 12288
> [17608.526254] 		extent data offset 0 nr 12288 ram 12288
> [17608.527858] 	item 90 key (266 108 172032) itemoff 10802 itemsize 53
> [17608.538634] 		extent data disk bytenr 13631488 nr 262144
> [17608.540392] 		extent data offset 172032 nr 36864 ram 262144
> [17608.542156] 	item 91 key (266 108 208896) itemoff 10749 itemsize 53
> [17608.544104] 		extent data disk bytenr 14716928 nr 4096
> [17608.545664] 		extent data offset 0 nr 4096 ram 4096
> [17608.547207] 	item 92 key (266 108 212992) itemoff 10696 itemsize 53
> [17608.549038] 		extent data disk bytenr 0 nr 0
> [17608.550440] 		extent data offset 0 nr 32768 ram 32768
> [17608.552056] 	item 93 key (266 108 245760) itemoff 10643 itemsize 53
> [17608.553997] 		extent data disk bytenr 14721024 nr 4096
> [17608.555578] 		extent data offset 0 nr 4096 ram 4096
> [17608.557113] 	item 94 key (266 108 249856) itemoff 10590 itemsize 53
> [17608.558861] 		extent data disk bytenr 14688256 nr 24576
> [17608.560439] 		extent data offset 12288 nr 12288 ram 24576
> [17608.562137] 	item 95 key (267 1 0) itemoff 10430 itemsize 160
> [17608.563756] 		inode generation 6 size 262144 mode 100600
> [17608.565261] 	item 96 key (267 12 256) itemoff 10411 itemsize 19
> [17608.566912] 	item 97 key (267 108 0) itemoff 10358 itemsize 53
> [17608.568715] 		extent data disk bytenr 14737408 nr 4096
> [17608.570283] 		extent data offset 0 nr 4096 ram 4096
> [17608.571810] 	item 98 key (267 108 4096) itemoff 10305 itemsize 53
> [17608.573502] 		extent data disk bytenr 13631488 nr 262144
> [17608.575033] 		extent data offset 0 nr 4096 ram 262144
> [17608.576507] 	item 99 key (267 108 8192) itemoff 10252 itemsize 53
> [17608.578416] 		extent data disk bytenr 13631488 nr 262144
> [17608.581054] 		extent data offset 8192 nr 167936 ram 262144
> [17608.583613] 	item 100 key (267 108 176128) itemoff 10199 itemsize 53=

> [17608.585846] 		extent data disk bytenr 13631488 nr 262144
> [17608.587883] 		extent data offset 188416 nr 4096 ram 262144
> [17608.590034] 	item 101 key (267 108 180224) itemoff 10146 itemsize 53=

> [17608.592397] 		extent data disk bytenr 13631488 nr 262144
> [17608.594415] 		extent data offset 180224 nr 81920 ram 262144
> [17608.595941] 	item 102 key (18446744073709551606 128 13631488) itemof=
f 10142 itemsize 4
> [17608.598465] 	item 103 key (18446744073709551606 128 13635584) itemof=
f 10082 itemsize 60
> [17608.601262] 	item 104 key (18446744073709551606 128 13697024) itemof=
f 9974 itemsize 108
> [17608.604090] 	item 105 key (18446744073709551606 128 13717504) itemof=
f 9946 itemsize 28
> [17608.606573] 	item 106 key (18446744073709551606 128 13774848) itemof=
f 9930 itemsize 16
> [17608.609125] 	item 107 key (18446744073709551606 128 13803520) itemof=
f 9842 itemsize 88
> [17608.611709] 	item 108 key (18446744073709551606 128 13905920) itemof=
f 9786 itemsize 56
> [17608.614269] 	item 109 key (18446744073709551606 128 13975552) itemof=
f 9782 itemsize 4
> [17608.616992] 	item 110 key (18446744073709551606 128 14123008) itemof=
f 9778 itemsize 4
> [17608.619523] 	item 111 key (18446744073709551606 128 14135296) itemof=
f 9710 itemsize 68
> [17608.622144] 	item 112 key (18446744073709551606 128 14209024) itemof=
f 9706 itemsize 4
> [17608.624841] 	item 113 key (18446744073709551606 128 14217216) itemof=
f 9538 itemsize 168
> [17608.627409] 	item 114 key (18446744073709551606 128 14471168) itemof=
f 9530 itemsize 8
> [17608.630034] 	item 115 key (18446744073709551606 128 14479360) itemof=
f 9510 itemsize 20
> [17608.632681] 	item 116 key (18446744073709551606 128 14499840) itemof=
f 9498 itemsize 12
> [17608.635448] 	item 117 key (18446744073709551606 128 14524416) itemof=
f 9394 itemsize 104
> [17608.638122] 	item 118 key (18446744073709551606 128 14700544) itemof=
f 9382 itemsize 12
> [17608.640633] 	item 119 key (18446744073709551606 128 14712832) itemof=
f 9370 itemsize 12
> [17608.643227] 	item 120 key (18446744073709551606 128 14737408) itemof=
f 9350 itemsize 20
> [17608.645834] BTRFS error (device dm-0): block=3D30949376 write time t=
ree block corruption detected
> [17608.648714] ------------[ cut here ]------------
> [17608.650272] WARNING: CPU: 2 PID: 27162 at fs/btrfs/disk-io.c:537 btr=
ee_csum_one_bio+0x297/0x2a0 [btrfs]
> [17608.652972] Modules linked in: dm_snapshot dm_thin_pool dm_persisten=
t_data dm_bio_prison dm_bufio dm_log_writes dm_flakey dm_mod dax btrfs bl=
ake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xx=
hash lzo_compress lzo_decompress raid6_pq loop [last unloaded: scsi_debug=
]
> [17608.660683] CPU: 2 PID: 27162 Comm: fsx Tainted: G             L    =
5.7.0-rc3-default+ #1094
> [17608.663520] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [17608.667102] RIP: 0010:btree_csum_one_bio+0x297/0x2a0 [btrfs]
> [17608.668919] Code: bc fd ff ff e8 aa e7 f0 c2 31 f6 48 89 3c 24 e8 ff=
 7b ff ff 48 8b 3c 24 48 c7 c6 78 75 25 c0 48 8b 17 4c 89 e7 e8 84 bc 0b =
00 <0f> 0b e9 8f fd ff ff 66 90 0f 1f 44 00 00 48 89 f7 e9 53 fd ff ff
> [17608.674610] RSP: 0018:ffffafbb81e978b8 EFLAGS: 00010292
> [17608.676299] RAX: 0000000000000000 RBX: ffff94287f810f00 RCX: 0000000=
000000001
> [17608.678260] RDX: 0000000000000000 RSI: ffffffff83109fc2 RDI: fffffff=
f8310a096
> [17608.680484] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000=
000000000
> [17608.682645] R10: 0000000000000000 R11: 0000000000008ca0 R12: ffff942=
85f298000
> [17608.684681] R13: ffff94274100bd30 R14: 0000000000000000 R15: 0000000=
0ffffff8b
> [17608.686659] FS:  00007f3479617b80(0000) GS:ffff94287ba00000(0000) kn=
lGS:0000000000000000
> [17608.689240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17608.691150] CR2: 0000000000466000 CR3: 000000010227f001 CR4: 0000000=
000160ee0
> [17608.693354] Call Trace:
> [17608.694341]  btree_submit_bio_hook+0x74/0xc0 [btrfs]
> [17608.696162]  submit_one_bio+0x2b/0x40 [btrfs]
> [17608.698391]  btree_write_cache_pages+0x373/0x440 [btrfs]
> [17608.700085]  ? lock_acquire+0xa3/0x400
> [17608.701257]  ? __filemap_fdatawrite_range+0xad/0x110
> [17608.702736]  do_writepages+0x40/0xe0
> [17608.703953]  ? do_raw_spin_unlock+0x4b/0xc0
> [17608.705290]  ? _raw_spin_unlock+0x1f/0x30
> [17608.706571]  ? wbc_attach_and_unlock_inode+0x194/0x2a0
> [17608.708167]  __filemap_fdatawrite_range+0xce/0x110
> [17608.709679]  btrfs_write_marked_extents+0x68/0x160 [btrfs]
> [17608.711384]  btrfs_sync_log+0x1a8/0xd40 [btrfs]
> [17608.712892]  ? btrfs_log_inode+0x370/0xe20 [btrfs]
> [17608.714459]  ? lock_acquire+0xa3/0x400
> [17608.715803]  ? lockref_put_or_lock+0x9/0x30
> [17608.717115]  ? dput+0x20/0x490
> [17608.718172]  ? dput+0x20/0x490
> [17608.719271]  ? do_raw_spin_unlock+0x4b/0xc0
> [17608.720639]  ? _raw_spin_unlock+0x1f/0x30
> [17608.722002]  btrfs_sync_file+0x335/0x490 [btrfs]
> [17608.723610]  __x64_sys_msync+0x19e/0x200
> [17608.724924]  do_syscall_64+0x50/0x210
> [17608.726143]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [17608.727719] RIP: 0033:0x7f34797f2743
> [17608.729030] Code: 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00=
 00 00 00 00 66 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 1a 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
> [17608.734572] RSP: 002b:00007ffe84f11858 EFLAGS: 00000246 ORIG_RAX: 00=
0000000000001a
> [17608.736913] RAX: ffffffffffffffda RBX: 00000000000008c8 RCX: 00007f3=
4797f2743
> [17608.738902] RDX: 0000000000000004 RSI: 000000000000293f RDI: 00007f3=
479814000
> [17608.740949] RBP: 00000000000278c8 R08: 000000000000001f R09: 00007f3=
479814900
> [17608.742896] R10: fffffffffffffd0c R11: 0000000000000246 R12: 0000000=
000002077
> [17608.744810] R13: 000000000000293f R14: 00007f3479814000 R15: 0000000=
000000000
> [17608.746764] irq event stamp: 0
> [17608.747948] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [17608.749754] hardirqs last disabled at (0): [<ffffffff83081b0b>] copy=
_process+0x67b/0x1b00
> [17608.752428] softirqs last  enabled at (0): [<ffffffff83081b0b>] copy=
_process+0x67b/0x1b00
> [17608.754935] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [17608.756871] ---[ end trace ddba49bd36651725 ]---
> [17608.758590] BTRFS: error (device dm-0) in btrfs_sync_log:3089: errno=
=3D-5 IO failure
>=20


--vWWMwPJwVPZiwdSsEMcA6lppf3jbE27Wx--

--PNxDAfg2xoe5ejZqZsVpiVmMdsbmAyzAN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl67ZSQACgkQwj2R86El
/qhr4wgAqNqXjNbG9I+irham3Mw4mFzaewz88Vm0fUs62sA2xy6VywImxPgVq7eD
X9PqoAEk2Yube3qQG0dfoqLYNa5KuHXVsUnWOAgEGXiAgiv9KqjAzxq5i93ccUVK
cSpCp79ZD+Nuy1tVd+Zj3HbGoHwmJcZtjeUtX6X3nZMV9Dc3tf2YBmhVY4kUf1X4
shm9ODMMBKhfzxZaVOTf07wUM6L/TEZwff72PPFX0TgeXM62l5kEQNpn0zfBcQJ2
hrv/H9WDLwNFsaDbgr9LaO+lLBExmh7H/1sMqxC4q4vg7vhw1/McLjHmJmNsjtFo
Si25HHky4mkHFHuga3Y72BsUZPEXfQ==
=PTxx
-----END PGP SIGNATURE-----

--PNxDAfg2xoe5ejZqZsVpiVmMdsbmAyzAN--
