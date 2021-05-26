Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D16390D2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 02:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhEZAH1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 20:07:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:55077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhEZAH1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 20:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621987555;
        bh=+J/rOGeyTQ1EWy/DS4TiDft8s4rFody306oYKf4ZQCI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NoqLFd10+nqsYCoqdwQ95HWHdgtJ+XSEbAbBW1fW0xfXGKwy1q3875HuGrkORcgGn
         ADxK7/TtO+IanedGEACNfjX+HVyGYHcf2iI+r1zlEBm3newaq4ukuxZUBLB/P4HWPz
         QA+QsQ7hVhSEdkBbzV5ha9j1tJvhDy0T1rLfXw+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2wL0-1liPGw0vfw-003L9c; Wed, 26
 May 2021 02:05:54 +0200
Subject: Re: [PATCH 8/9] btrfs: simplify eb checksum verification in
 btrfs_validate_metadata_buffer
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621961965.git.dsterba@suse.com>
 <6828072ccda5d55b9d130f48b750455ea728781b.1621961965.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <0b51e0c9-896a-4ee2-f965-eec7b57cbd39@gmx.com>
Date:   Wed, 26 May 2021 08:05:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <6828072ccda5d55b9d130f48b750455ea728781b.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o97XkkBkNAk1kNAWN+LmJQtkhZk4fp3V256R3oMfBJyfaHr/MKi
 y8V8/Vz7leZ6G9x4cK7lLr+4G7Mw7jB4/QvUYNtEOrw1K+pRvkMfZHpwom2ezWxO8xr5ihu
 UgFfyBbF1nAmEUol5/Cr4F0/d4ME3IHPVWEhSJB9eClBB0vMvmNNCUwiySSIGO98J9kCRmO
 tv3yi8BfOE02opRcfDlOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yePdb35H5wc=:1DCvRpppQdm2+dx43R/9ga
 7T59O7TaYmXsFHWMGg0KVIA8YSUJUilCd8mzuM/ox1H68uG8wP3CW6NEWsx8KJGI36Rv/7JC5
 6loPxFtiRBHBNjBQlUIzFaCyoOivAyAzMRv49HhTS7MkjT4dypvG1aNKtEewBiUJ5Ws+uzJ4C
 O/RQkz37Z+ztIUAb/7FzKztCCBnXrdjAzFN17EN0M8dwHigrIIw6joWL9n3KxF+TyE+/m23Fg
 VhJltyxJtY44as2sOKrfAqYlvYL4rz0tjteZ+Py8DJodu4fRJ7I9DHLM8YR6+BNfn5YHJyv7P
 cEmZRm33asv6AWOdgLyrZ7MhEQvlsJISYCj5Qp2etPKpqMgEpMlhy1aQlGNAvpmJlu304fG0F
 B6LQs3/YdlW25MFxn2xtpUiW7hpNXcl+UVQRClwLlnO2v1HfKD9Ryib/4iW37L4OlzRgpMEdu
 Q1v1LZFbnR6cl1NHwzpKHC/Pgo66jorS4dl2fAOR1d3e3L+YBC04D5kARTBdYJeUs8ppNAB1F
 Pp/ZjjKEh4MYDVuacW3f+cDnGm16ImdJ1ZeY3hLxHcfVPjBzXOzq86XHCPsLPGjw+LOcVPsk5
 NkwD/h7jupWRxSPSzrkzAoH5AdTLg43UHgZ9jxwxCf+Macu6qADUsIzvyWuRTKgpqYxejVcmC
 stJpD3yDGiNH95/ue9Yvlx8T84LvmPYZs2hOcVf+BZkXdBd14vGk3NYiqBV9XSG1VgiDzDKRS
 Usk51g3EPY+RTd2ZZ5/8OSbM8WYojD5wmlYbxlnVEH8qY2hPCqybfbBULU26UTa8DDGqcTFvf
 nw5Z+rnNx8OsxfF7LaScfpOBz+i8jH7VFvbQxpE0w4GQJm0YEp7kFSJ0O4VwooBUokHMVhZF5
 luaPOX2ipEx4Xp4JRi1qh/FC4OHh6oU6DdiXuMv6r94EiT83atJzOVnA1WR1QLUeowijEpor6
 6J15dkS380IJn1AitIgg2qZm73qzoLdZjwz9M4URSGnJ41hxdL/cNIa1NhYT7nu3YnpfjEFo5
 WF92hnwSbmvwonR31P/lLGM4dR2g9piYxWVdMHAFWcEGQh//jfTOIl2YcuoNNRlmBP8I7EcXa
 Ubu71EXMn1BOXl0WJZGl4hAlOUZoQyWCyTKXrDBpuVYiRtrl40TqZF1fw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/26 =E4=B8=8A=E5=8D=881:08, David Sterba wrote:
> The verification copies the calculated checksum bytes to a temporary
> buffer but this is not necessary. We can map the eb header on the first
> page and use the checksum bytes directly.
>
> This saves at least one function call and boundary checks so it could
> lead to a minor performance improvement.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

The idea is good, and should be pretty simple to test.

Reviewed-by: Qu Wenruo <wqu@suse.com>

But still a nitpick inlined below.
> ---
>   fs/btrfs/disk-io.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 6dc137684899..868e358f6923 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -584,6 +584,7 @@ static int validate_extent_buffer(struct extent_buff=
er *eb)
>   	const u32 csum_size =3D fs_info->csum_size;
>   	u8 found_level;
>   	u8 result[BTRFS_CSUM_SIZE];
> +	const struct btrfs_header *header;
>   	int ret =3D 0;
>
>   	found_start =3D btrfs_header_bytenr(eb);
> @@ -608,15 +609,14 @@ static int validate_extent_buffer(struct extent_bu=
ffer *eb)
>   	}
>
>   	csum_tree_block(eb, result);
> +	header =3D page_address(eb->pages[0]) +
> +		 get_eb_offset_in_page(eb, offsetof(struct btrfs_leaf, header));

It takes me near a minute to figure why it's not just
"get_eb_offset_in_page(eb, 0)".

I'm not sure if we really need that explicit way to just get 0,
especially most of us (and even some advanced users) know that csum
comes at the very beginning of a tree block.

And the mention of btrfs_leave can sometimes be confusing, especially
when we could have tree nodes passed in.

Thanks,
Qu
>
> -	if (memcmp_extent_buffer(eb, result, 0, csum_size)) {
> -		u8 val[BTRFS_CSUM_SIZE] =3D { 0 };
> -
> -		read_extent_buffer(eb, &val, 0, csum_size);
> +	if (memcmp(result, header->csum, csum_size) !=3D 0) {
>   		btrfs_warn_rl(fs_info,
>   	"checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT =
" level %d",
>   			      eb->start,
> -			      CSUM_FMT_VALUE(csum_size, val),
> +			      CSUM_FMT_VALUE(csum_size, header->csum),
>   			      CSUM_FMT_VALUE(csum_size, result),
>   			      btrfs_header_level(eb));
>   		ret =3D -EUCLEAN;
>
