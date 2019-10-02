Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E860C86B8
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 12:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfJBKwU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 06:52:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:39994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbfJBKwT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 06:52:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E143AD77;
        Wed,  2 Oct 2019 10:52:17 +0000 (UTC)
Subject: Re: [PATCH 1/3] btrfs: add __cold attribute to more functions
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1569587835.git.dsterba@suse.com>
 <244616cd0a823e44fcca051a569ff68e0c7dc29e.1569587835.git.dsterba@suse.com>
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
Message-ID: <cc58a307-c3af-f2e1-b309-016c5bed5088@suse.com>
Date:   Wed, 2 Oct 2019 13:52:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <244616cd0a823e44fcca051a569ff68e0c7dc29e.1569587835.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1.10.19 г. 20:57 ч., David Sterba wrote:
> The attribute can mark functions supposed to be called rarely if at all
> and the text can be moved to sections far from the other code. The
> attribute has been added to several functions already, this patch is
> based on hints given by gcc -Wsuggest-attribute=cold.
> 
> The net effect of this patch is decrease of btrfs.ko by 1000-1300,
> depending on the config options.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/disk-io.c | 4 ++--
>  fs/btrfs/disk-io.h | 4 ++--
>  fs/btrfs/super.c   | 2 +-
>  fs/btrfs/volumes.c | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index e335fa4c4d1d..04d86e11117b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2583,7 +2583,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
>  	return ret;
>  }
>  
> -int open_ctree(struct super_block *sb,
> +int __cold open_ctree(struct super_block *sb,

According to the documentation
(https://gcc.gnu.org/onlinedocs/gcc/Function-Attributes.html) of gcc
attributes are placed in the declaration of a function (3rd paragraph):


"Function attributes are introduced by the __attribute__ keyword in the
declaration of a function, ..."

>  	       struct btrfs_fs_devices *fs_devices,
>  	       char *options)
>  {
> @@ -3968,7 +3968,7 @@ int btrfs_commit_super(struct btrfs_fs_info *fs_info)
>  	return btrfs_commit_transaction(trans);
>  }
>  
> -void close_ctree(struct btrfs_fs_info *fs_info)
> +void __cold close_ctree(struct btrfs_fs_info *fs_info)
>  {
>  	int ret;
>  
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index a6958103d87e..76f123ebb292 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -49,10 +49,10 @@ struct extent_buffer *btrfs_find_create_tree_block(
>  						struct btrfs_fs_info *fs_info,
>  						u64 bytenr);
>  void btrfs_clean_tree_block(struct extent_buffer *buf);
> -int open_ctree(struct super_block *sb,
> +int __cold open_ctree(struct super_block *sb,
>  	       struct btrfs_fs_devices *fs_devices,
>  	       char *options);
> -void close_ctree(struct btrfs_fs_info *fs_info);
> +void __cold close_ctree(struct btrfs_fs_info *fs_info);
>  int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>  struct buffer_head *btrfs_read_dev_super(struct block_device *bdev);
>  int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c> index 843015b9a11e..3da35d8b21a3 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -187,7 +187,7 @@ static struct ratelimit_state printk_limits[] = {
>  	RATELIMIT_STATE_INIT(printk_limits[7], DEFAULT_RATELIMIT_INTERVAL, 100),
>  };
>  
> -void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
> +void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
>  {

Is printk really cold though? It's used in the various print helpers,
even for info level print which might not be rare once the fs is
mounted? What's a possible negative effect of this size optimisation -
runtime cost?

>  	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
>  	struct va_format vaf;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fed4c9fe2ea2..3fd89aee539d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2048,7 +2048,7 @@ static struct btrfs_device * btrfs_find_next_active_device(
>   * where this function called, there should be always be another device (or
>   * this_dev) which is active.
>   */
> -void btrfs_assign_next_active_device(struct btrfs_device *device,
> +void __cold btrfs_assign_next_active_device(struct btrfs_device *device,
>  				     struct btrfs_device *this_dev)
>  {
>  	struct btrfs_fs_info *fs_info = device->fs_info;
> 
