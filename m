Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F5B3207E4
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 02:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhBUBKD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 20:10:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:36013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhBUBKC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 20:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613869703;
        bh=yzC9lwD+pZXo7DY1noX5Q0pFuJzSSd+9hy6LtXiVt/4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NbkTsIj9YBBrXallcFEydpUqLTy9z/j9E0mpsBVchMaubzy6UiVHFpX5cVdmRRiw1
         cEU3LY1HpkpQv+gItEwHfQF6MB/9fI6gX7m4kvL+i8KVoY3FSzi+08F8I8uTd/nBXk
         8cdYLrrF8hHx6JsfI8mNOWQKq39kgJOsytaba52g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdNY2-1lmgw218cq-00ZPXc; Sun, 21
 Feb 2021 02:08:22 +0100
Subject: Re: ERROR: failed to read block groups: Input/output error
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOE4rSyacNvoACo7+CYc76=WFS6XYtKMJg9akV61qfnnR1uTGg@mail.gmail.com>
 <20210219192947.GJ32440@hungrycats.org>
 <CAOE4rSwPALKbk8Wv4eqnapbXKb=MeG2gYmGezWybx-mJ2ZPXXw@mail.gmail.com>
 <CAOE4rSyf06YjongJ2h1tpMXJeYj6wGV7TKV9AK_c8M1+7o4NsA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2a600c23-eb54-6b4b-70dd-8053ed210601@gmx.com>
Date:   Sun, 21 Feb 2021 09:08:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAOE4rSyf06YjongJ2h1tpMXJeYj6wGV7TKV9AK_c8M1+7o4NsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pdkMHRmsgP8Yf+nYIy92z+Nj884k7hVatCVpBkNODDD5etaZMQp
 9jPQdhUC3BI1CstjQxAkTnYy+JemM9Z538+yTabqNvF44mAunALxg//MDX2KZHaheIIzFyB
 5KRK3qWAa95lXOB3Zs7/mdRCvn1m+BTyJyGi7VD+L86iWzRfhx1xU+c9AKR3c2OoPt8yBb0
 RBOQKu/MGQcXQ6bzMZyXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:68mG+xJLTBk=:CbTUpU5K4q6d1ui7eZnSbp
 VyOtM/4DgQe39QnFW76Afeu9hcmY8KdBfQtK+9F9+SU5QSuTaNgtkrWbZRUhr5p0DrB7SlKKh
 Ju+AgZqkXY0rSJ+5sZ2y9jwdgMlYZet/c46t4XYoIpeVQzRSNwLCMmmP9M8HrdzvajopYTe/o
 fwnT4rRJPzyTI0KKcJBSVoYcdS+3rCiOxjT3Zvi7T8LkoIL5KI7TnydW5ErgoKollqKU/d3m9
 iKIe8lutty1NgW48dGgS5/WZEQ3Q+9ebac9NaXjC6m23KnqnHGnl0gO4BM/Sd5z7iq1HlNG8Y
 AHuglDnONIQVAK33JhA1rXJeWWRnoCu352/ktmjp4R/H4CaEcQasuKNO4E+KcJCrNlZgIdXI7
 cqZg0VgRxFXQmpUcDLF6QQgdCtW2st/VZd5UfyJ+2G4o6KOJZIhkbfCBoQlpoekR7CxxBOF8T
 WctNzfAWKKYT26WHYYElu9vzumrEpgKGn3PZ6WQ3DB4ha9Rbef7wf8jgFzuPkyZ7CvTwg1sjI
 6ywTe0PjiISHgwA1dQjBjhwKYbsr45CLaReXd9wglqLNcAfzJr/xGjaflcudMVOT+U1LTBjMv
 VUhts8W3A/vscZAnHJF9LuSshLcqHyvoTTDSkE5CbZdWczuu4RO3cdYQpZwyJ44NfNactOg4S
 +nG6tafqEPyO1xkloZ3LgfPLMb0QdR7YqQMNyp8frzKz6WSxO1g4WOEtQve3RWxAD+o1qXYBy
 CJDAiRA5eT74a4Bjs4JFuF20ZNB3D8Z2dbTHo3WE/UwQDA2At/OKX6HicunzaJBLE1pkNj54e
 vLW/Hm1HXDzPHHJKE/nOo0OYZ72clQvEhvdX9nYDoVCD6z1k0cXKBi7UTmx/8HdAJ0cwsP0mk
 nSnUSfuSE18xTL69QYow==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/21 =E4=B8=8A=E5=8D=889:03, D=C4=81vis Mos=C4=81ns wrote:
> I just found something really strange, it seems pointers for extent
> tree and csum tree have somehow gotten swapped...

Only the latest 2 backup roots are supposed to be correct, older ones
are no longer ensured to be correct.

This is not strange.

Thanks,
Qu
>
> $ btrfs inspect dump-super -f /dev/sda | grep backup_extent_root
> backup_extent_root:     21056867106816  gen: 2262737    level: 3
> backup_extent_root:     21056867762176  gen: 2262738    level: 3
> backup_extent_root:     21057133690880  gen: 2262740    level: 3 <<
> points to CSUM_TREE
> backup_extent_root:     21056854228992  gen: 2262736    level: 3
>
> $ btrfs inspect dump-super -f /dev/sda | grep backup_csum_root
> backup_csum_root:       21056868122624  gen: 2262737    level: 3
> backup_csum_root:       21056944685056  gen: 2262738    level: 3
> backup_csum_root:       21057139916800  gen: 2262740    level: 3 <<
> points to EXTENT_TREE
> backup_csum_root:       21056857341952  gen: 2262736    level: 3
>
> $ btrfs inspect dump-tree -b 21057133690880 /dev/sda | head -n 2
> btrfs-progs v5.10.1
> node 21057133690880 level 1 items 316 free space 177 generation
> 2262698 owner CSUM_TREE
>
> $ btrfs inspect dump-tree -b 21057139916800 /dev/sda | head -n 2
> btrfs-progs v5.10.1
> leaf 21057139916800 items 166 free space 6367 generation 2262696 owner
> EXTENT_TREE
>
>
> Previous gen is fine
>
> $ btrfs inspect dump-tree -b 21056867762176 /dev/sda | head -n 2
> btrfs-progs v5.10.1
> node 21056867762176 level 3 items 2 free space 491 generation 2262738
> owner EXTENT_TREE
>
> $ btrfs inspect dump-tree -b 21056944685056 /dev/sda | head -n 2
> btrfs-progs v5.10.1
> node 21056944685056 level 3 items 5 free space 488 generation 2262738
> owner CSUM_TREE
>
> Also generation specified in backup root doesn't match with one in
> block so seems like latest gen wasn't written to disk or something
> like that.
>
> In root tree there is different extent tree used than one specified in
> backup root.
> $ btrfs inspect dump-tree -b 21057011679232 /dev/sda | head -n 6
> btrfs-progs v5.10.1
> node 21057011679232 level 1 items 126 free space 367 generation
> 2262739 owner ROOT_TREE
> node 21057011679232 flags 0x1(WRITTEN) backref revision 1
> fs uuid 8aef11a9-beb6-49ea-9b2d-7876611a39e5
> chunk uuid 4ffec48c-28ed-419d-ba87-229c0adb2ab9
> key (EXTENT_TREE ROOT_ITEM 0) block 21057018363904 gen 2262739
>
