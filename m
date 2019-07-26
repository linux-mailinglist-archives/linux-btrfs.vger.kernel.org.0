Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31E775D45
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 05:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGZDJ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 23:09:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:53983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfGZDJ7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 23:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564110591;
        bh=jpTG0GqMm8CXqRo9fzUNWrJyB9ncfY/1vxXbJZ1szg4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=J1+emSCdVDBQ26qQqAgMp6FRVNSFUpA6aNr6gyBpVhtQLo10wdZT8FHvmqJKzbRYc
         6GMcq8cNddS3paeR0QVuwIldNiz7VPdZMjMvEJDrT92YREoPW4nogdYBmtvpYtimnp
         93KukrVld2z00cb9isvV4Ec4ANCWyJU6nHN99E40=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.137] ([34.92.239.241]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MPUZ7-1hmk0d2Udt-004mYa; Fri, 26
 Jul 2019 05:09:51 +0200
Subject: Re: [RFC PATCH 2/4] btrfs: create structure to encode checksum type
 and length
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <944b685765a68c3389888159d3fe228c2e78eb22.1564046812.git.jthumshirn@suse.de>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <46419ff0-a625-0738-6a57-0ab903636fd8@gmx.com>
Date:   Fri, 26 Jul 2019 11:09:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <944b685765a68c3389888159d3fe228c2e78eb22.1564046812.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:meDatBeh3F5kG1A5tapnZAYRsXoYD1w7CHYsRyvitvx6xZN9s2a
 b0ukrqznkONi6BSyXrCaAd6tHFr4ou5gEtEGsg7V9R6qhdka6hpQVMeelP1DTU1fz2PISAi
 1fJmRg3P5J4WpwGD65aW+c8wfMEgtG+Fq/rpEVrUPxiT+tElmXIwTeXfKEr+NfJnvAlfXgh
 y/Fn0dNHU4sDb8Z7/ZTGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:52LajNwg2Bw=:rxHziyDw4uWV2PwYudZT32
 M7u0SQYAka+f7Yi2xlwVEFG6ltkm0uCfYjAM+Kqt9ULzB/nh2y5aUFPk/XptXVpMdNPbWn1G+
 EVrB93i5/B3VNVpRVMTT5AW3yzDlkh8ZyIMf/BWtuyL+youJOxfb/XDEDuBstLxAs/tJPDc+I
 P2LJj02jWmK5YrjBZ1MFd0bgKl7lOi/9/vtXVfNyAhj4rfFInN4sqtFkQVBUj1a0x6uO83dG0
 wH6Wzt5eqErCbHbYHag3l2W3IN/6OtZTyUmqbviszXNAcGu0PTSvPZWMn4M4Wmd8sjKjzX0ky
 3QiiqG3LP+biGm5lbVvyVrd3rJThUCDcBMlHXl/um1P4LD2ktAPxVzZ5qLy5KgAYWclXPje3m
 6aHC/xmk6o3zqbadyzW9buGWLqKfDisXCPcUWHE02AHKvQ67JDwxILMZU1cfgWH/THShxr45X
 fP0XSiH3+PMhKWGXHw71MnsrV2OmWnR46HJx+OMVacRjaYaAxdRQnLTNPNQeoxzXugzNJkS6F
 e1cADIhHP1iGuAR9qRkKcMUBTvTjwaG+1hWyVn01bHf1L3RrP0j74RoEChgdOng/md9b3/3R6
 vAz0+ljaPzTO/ErkMjT7PyoA4eE0EckkabWKEPK2NDRO+FOu86X0y16H949ja8luivxDEe08b
 Ie0uaeRDhd4tVeAGJloxDtanpBCXEQvq/1fE8gO/1IMhWIik1Y17uwfINufI81RLpDh5UraMM
 6ZBEDW1VWu/LaAeShC3WpkE92LR3B6iSbNV/3QralDZMGhAtGsF3Dg9m49nvCVYDiOn/Ah55N
 2rMw1V25UwYPWxVqHBSSSEFrf+8oQwbBCGH89ISho1nvzCqKAIfTZo4nAWvcTFUN856HH676M
 5y5ZSY9mC9GvYi57XcKlLMJn2V7HGShVzfxHitTwovt0AqcWqVr417y0IiKqC6p44Su06XqKW
 b0YVbs7ahOvaHiq9Qf85v7PgxpwKbdfEakg0F36+2xNCHNEfSPPKArSB8k/EoQWhwpIJEV+/w
 RMBpWYQbScwvodK13S+rUyXlSBm8UozfNUARW1h90jXrueP5CyD5TANsAq+Jgz68WT9mJtjRj
 RBmcNi4riimZd4ksfLeppxNrwSPsSc4K4c5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/25 5:33 PM, Johannes Thumshirn wrote:
> Create a structure to encode the type and length for the known on-disk
> checksums. Also add a table and a convenience macro for adding the
> checksum types to the table.
>
> This makes it easier to add new checksums later.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>   fs/btrfs/ctree.h | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index da97ff10f421..099401f5dd47 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -82,9 +82,15 @@ struct btrfs_ref;
>    */
>   #define BTRFS_LINK_MAX 65535U
>
> -/* four bytes for CRC32 */
> -static const int btrfs_csum_sizes[] =3D { 4 };
> -static const char *btrfs_csum_names[] =3D { "crc32c" };
> +#define BTRFS_CHECKSUM_TYPE(_type, _size, _name) \
> +	[_type] =3D { .size =3D _size, .name =3D _name }
> +
> +static const struct btrfs_csums {
> +	u16		size;
> +	const char	*name;
> +} btrfs_csums[] =3D {
> +	BTRFS_CHECKSUM_TYPE(BTRFS_CSUM_TYPE_CRC32, 4, "crc32c"),
> +};
>
How about:

struct btrfs_csum {
         u16             size;
         const char      *name;
};

static const struct btrfs_csum btrfs_csums[] =3D {
#define BTRFS_CHECKSUM_TYPE(_type, _size, _name) \
              [_type] =3D { .size =3D _size, .name =3D _name }

         BTRFS_CHECKSUM_TYPE(BTRFS_CSUM_TYPE_CRC32, 4, "crc32c"),
};

Since the macro BTRFS_CHECKSUM_TYPE is only used in array btrfs_csum
btrfs_csums. And this makes the struct btrfs_csum clear.


=2D--
Su

>   #define BTRFS_EMPTY_DIR_SIZE 0
>
> @@ -2373,13 +2379,13 @@ static inline int btrfs_super_csum_size(const st=
ruct btrfs_super_block *s)
>   	/*
>   	 * csum type is validated at mount time
>   	 */
> -	return btrfs_csum_sizes[t];
> +	return btrfs_csums[t].size;
>   }
>
>   static inline const char *btrfs_super_csum_name(u16 csum_type)
>   {
>   	/* csum type is validated at mount time */
> -	return btrfs_csum_names[csum_type];
> +	return btrfs_csums[csum_type].name;
>   }
>
>   /*
>


