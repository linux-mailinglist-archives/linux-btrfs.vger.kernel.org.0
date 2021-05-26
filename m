Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9F5392315
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 May 2021 01:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhEZXPH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 19:15:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:57123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234724AbhEZXPD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 19:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622070808;
        bh=F+sNASMhqsAP30g8+s2886dSC/Dn6CXwXaU6/3ecxOY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gmcoSVKObhdn7JNH0G8+qFxmQ4NTK1ZX2oX+diS8YkqvIV66UPOK8c+keu0NwpqaB
         d9zmgavMUSCOnr4flPcv6GDMcle7zdF/pQkbyfk2PbA8tpIgXtyFDbNv4erP47abRx
         uYwPOT5mpnDCXs1g1RzQIOcBZUk/yuFo8iPhzGVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGQnP-1lednW2W3J-00GsxV; Thu, 27
 May 2021 01:13:28 +0200
Subject: Re: [PATCH 8/9] btrfs: simplify eb checksum verification in
 btrfs_validate_metadata_buffer
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1621961965.git.dsterba@suse.com>
 <6828072ccda5d55b9d130f48b750455ea728781b.1621961965.git.dsterba@suse.com>
 <0b51e0c9-896a-4ee2-f965-eec7b57cbd39@gmx.com>
 <20210526163139.GG7604@twin.jikos.cz> <20210526165844.GI7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <83c7646d-4130-1923-56f5-442e27d85ad6@gmx.com>
Date:   Thu, 27 May 2021 07:13:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210526165844.GI7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gccnkXnWB54CTrEdgGDWLuPW1ImIWACF3ljjYhIxFZEs669Kxex
 GUJaUg2h1IUOQQG+4rSuu2Yv3K9gn5OW31Vhz/PDRb9+KvRU06lP54Dx+z7uH+VdkfsSc9/
 12Gh0bspVEFWUMPyFnngchv7WHouYrsNUe7JBVfvtFdnHX93j2U/ed6mCmmW9MU4UfWbra2
 xDsMGd1ooUk7LkHGwigdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vFnvZAO1gfI=:hbiGQnBt0e1Jc1BpGcvkvL
 uuMWbObB/d1lyO08IvKAAhGE0p+mCrzgn8jMh13CgvGkHBpvb7G1E9OI+eYF9kXQJMG/PiKq4
 0c/i0YE7QIWPpW5oC/+URhuRsgnD6eLObsnckO8CS05nRbd4Crmh/2mug26SJixnMz9felj26
 l6V5aA9p2FQJ7EeRPwE8QB4tjlHa7S+HzY5wvq1leFrQyRLBf37rPdMJZvBh4R7lc5f7PnYW3
 sJEAreDlUlCTX8pEVl14aAJNTyFFi4pwzXU1qIMJG0bg3kf4JfPfvN2BRMkR1XwyN53JjFXa+
 QwNWUpwFOrpO8HuV1nCNn2UR00cxt3C0RJtT6C/WlwPGuz5EK877bgUpc/iEKbxPyfGUEo2M2
 k3XoyQz9Gt7D2rQ9kNiYzKhRldDGUar0N9t0q6N65XPbEhMf8qDjhOtwJqjdlQXdUy69lVFTx
 IeakOEcqCx+sphDK6/+Z6BgSDKbPlzp9D6DjQvUXZxt/3jZA9JnODhfoX5zEC26v2zy7/KAGd
 fRjYm6c07t/Mz04xQFBleHBlBd2JsmAOSNKQgDhXmayF1si25AlW1o44Baw3vgPMnHJStkm/g
 yjlG+OqhyyZ9SegzUnhLSNlyHRj/FfEnbiqj7CdoOmi1YH6B6iB8yLm+FY9ghmJrIk8Q9v7Sm
 hP7PAiuVKC2LziqB+qlrAufaTyJLY9rvE5YIodEO1pvHsl34j9xyxom6zhrt0pM2UBTCQNqsM
 +8dTEWx6UP13yS9j8EeYJC2o1oY2SGq3xPCKFDUlFhLGYADLXWP4gz7Mfr03F0WM9txOnbD2P
 Gp7C4pqzpA9HIIl2fys+YGMMAwJga9QuS2RB70wjHbcVucBEJxVzo3eJQYJs+WA0hy2Ag8DQh
 7gdKskJ94SZz0kMjGsOT9sI6/c+8BL1rWsAmulNTZXEkmxgtvF8/cqzkC2YjomZ5yYtotwPSl
 hsoRziTILGl9lfYLlBWP/8ZXpYuI5o9lP9dlNSZuvvkVTdUldkASl4O5/Co+2D+7w8SnvsEkg
 +O17jL+mf6Ob4+X4I/SZby1FfPVgcLCvaXinaTKCN0dlOaq5pgZ/W0Pt5aCnUVAokL2KvKEDV
 HFjp2x7FiR6myHx4/rrbOEkPofTe2wXqLSjCcuZYz0SW7IVB1o22GnFEkx5W/kp5k1h4xNmqM
 ki1aLgR7oUC9mw3LV1qVAWKgRBkEQN01nphF3edWSNx/0L+7HbWhzFaRrQf4wUerN2r0ZKnmm
 QH+QTsMLXPXzTDRD9
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/27 =E4=B8=8A=E5=8D=8812:58, David Sterba wrote:
> On Wed, May 26, 2021 at 06:31:39PM +0200, David Sterba wrote:
>>>> +	header =3D page_address(eb->pages[0]) +
>>>> +		 get_eb_offset_in_page(eb, offsetof(struct btrfs_leaf, header));
>>>
>>> It takes me near a minute to figure why it's not just
>>> "get_eb_offset_in_page(eb, 0)".
>>>
>>> I'm not sure if we really need that explicit way to just get 0,
>>> especially most of us (and even some advanced users) know that csum
>>> comes at the very beginning of a tree block.
>>>
>>> And the mention of btrfs_leave can sometimes be confusing, especially
>>> when we could have tree nodes passed in.
>>
>> Ah right, I wanted to use the offsetof for clarity but that it could be
>> used with nodes makes it confusing again. What if it's replaced by
>>
>> 	get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
>>
>> This makes it clear that it's the checksum and from the experience we
>> know it's at offset 0. I'd rather avoid magic constants and offsets but
>> you're right that everybody knows that the checksum is at the beginning
>> of btree block.
>
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -584,7 +584,7 @@ static int validate_extent_buffer(struct extent_buff=
er *eb)
>          const u32 csum_size =3D fs_info->csum_size;
>          u8 found_level;
>          u8 result[BTRFS_CSUM_SIZE];
> -       const struct btrfs_header *header;
> +       const u8 *header_csum;
>          int ret =3D 0;
>
>          found_start =3D btrfs_header_bytenr(eb);
> @@ -609,14 +609,14 @@ static int validate_extent_buffer(struct extent_bu=
ffer *eb)
>          }
>
>          csum_tree_block(eb, result);
> -       header =3D page_address(eb->pages[0]) +
> -                get_eb_offset_in_page(eb, offsetof(struct btrfs_leaf, h=
eader));
> +       header_csum =3D page_address(eb->pages[0]) +
> +               get_eb_offset_in_page(eb, offsetof(struct btrfs_header, =
csum));

This version looks better to me.

THanks,
Qu
>
> -       if (memcmp(result, header->csum, csum_size) !=3D 0) {
> +       if (memcmp(result, header_csum, csum_size) !=3D 0) {
>                  btrfs_warn_rl(fs_info,
>          "checksum verify failed on %llu wanted " CSUM_FMT " found " CSU=
M_FMT " level %d",
>                                eb->start,
> -                             CSUM_FMT_VALUE(csum_size, header->csum),
> +                             CSUM_FMT_VALUE(csum_size, header_csum),
>                                CSUM_FMT_VALUE(csum_size, result),
>                                btrfs_header_level(eb));
>                  ret =3D -EUCLEAN;
>
