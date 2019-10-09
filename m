Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0BD1128
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 16:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfJIOZU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 10:25:20 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36469 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbfJIOZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Oct 2019 10:25:19 -0400
Received: by mail-vs1-f66.google.com with SMTP id v19so1646352vsv.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2019 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1nuhf2+DKZ9s2lmP4XTENUkLKH+hI8fzjr1ewm0aJWs=;
        b=BOUKw/vXOK3RW6ez8mc2Ql3NiLvZz7J8KtCRO4NLEAI7ZE6ScI9INMod0FphGPo/fr
         bpG11uRAhoTGobt3Yg7a22/00nu18j8mQthdzajUUqynTR6ZZMG6vLkavSbpyPwcd7Yb
         GzW6Yh3SuXXnvNMJOxe2f5Dy33jjJViT9GdHfM/VEKVM/Wl+EAVeIgirdX3YymqI2JAL
         xy+t710/QKNiQh9tu716YyiKbjJQ+kmVo/Q23CwN8PWGKVxjV2rVeZLRp3dD+hiI+Xqe
         c47pBgbelpsNBUScEdKGQNkbNtWFcntSMKIhZcroe/60fl57S2Q0sVICmAyWp34uGUKa
         KYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1nuhf2+DKZ9s2lmP4XTENUkLKH+hI8fzjr1ewm0aJWs=;
        b=pvCQ9+71I0ZHQpYYtwDBoCWoMABCGvygdGqDt2UiJO51g36Tn3nSEwEGkFroShhxxw
         0qWEDPHvcODm2opsDN6YBxauhzsNwMDsjdtD8gOs0hMrNU34eXYl0gmcyneI1NqhlMYY
         Nan4ktks6xeHLxIEVNlPhd97JcvKc9M0De7qjhMcA9nxLUlamfRax2JXgrfQawxruGhe
         WXb1k93LDwk7EH+yw56mYuR+bAhZnaVadfikbk0RlIV1ZB8Af+J5bJ1otG+8g7Tqjli9
         ZYSvapopBL2+uiivEWf/iOfWtoFg6x08mtxGO7a7qtgmqs2RZy41yXGrQznkicFBBkLg
         F5gw==
X-Gm-Message-State: APjAAAV00yGeoEtTj5Kxe0leInWdIo5RZ2Y2RBZPxLyF1N9jbTmb4A0k
        cxIDiWVYMVSPg0Rxo6LxIjhUEE1fWO9eesz5gf8=
X-Google-Smtp-Source: APXvYqwti9yEm7MlLZcl4KM7tLQfNX3IGLaVg7FxurJDeDXRdP/un4L0BGjapdnUvjfL4FbUXKBsYYf6gtMyfGM4kdw=
X-Received: by 2002:a67:ba16:: with SMTP id l22mr1880446vsn.14.1570631117954;
 Wed, 09 Oct 2019 07:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191008044909.157750-2-wqu@suse.com> <20191009130747.47252-1-wqu@suse.com>
In-Reply-To: <20191009130747.47252-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 9 Oct 2019 15:25:06 +0100
Message-ID: <CAL3q7H4JMMVKmSqCM-5+1WLmC4TYLUfF8e7ZNS132LmO4n2iHg@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: block-group: Refactor btrfs_read_block_groups()
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 9, 2019 at 2:09 PM Qu Wenruo <wqu@suse.com> wrote:
>
> Refactor the work inside the loop of btrfs_read_block_groups() into one
> separate function, read_one_block_group().
>
> This allows read_one_block_group to be reused for later BG_TREE feature.
>
> The refactor does the following extra fixes:
> - Use btrfs_fs_incompat() to replace open-coded feature check
> - Fix a missing "btrfs_put_block_group(cache)" in error path

I think that (the bug fix for the error path) should go into a
separate patch, so that it can be backported without adding a refactor
(something not meant for stable releases).

Thanks.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> ---
> Changelog:
> v2.1->v2
> - Add commit message for the fixes done in the refactor
> - Add reviewed-by tags
> ---
>  fs/btrfs/block-group.c | 214 +++++++++++++++++++++--------------------
>  1 file changed, 108 insertions(+), 106 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index bf7e3f23bba7..0c5eef0610fa 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1687,6 +1687,109 @@ static int check_chunk_block_group_mappings(struc=
t btrfs_fs_info *fs_info)
>         return ret;
>  }
>
> +static int read_one_block_group(struct btrfs_fs_info *info,
> +                               struct btrfs_path *path,
> +                               int need_clear)
> +{
> +       struct extent_buffer *leaf =3D path->nodes[0];
> +       struct btrfs_block_group_cache *cache;
> +       struct btrfs_space_info *space_info;
> +       struct btrfs_key key;
> +       int mixed =3D btrfs_fs_incompat(info, MIXED_GROUPS);
> +       int slot =3D path->slots[0];
> +       int ret;
> +
> +       btrfs_item_key_to_cpu(leaf, &key, slot);
> +       ASSERT(key.type =3D=3D BTRFS_BLOCK_GROUP_ITEM_KEY);
> +
> +       cache =3D btrfs_create_block_group_cache(info, key.objectid,
> +                                              key.offset);
> +       if (!cache)
> +               return -ENOMEM;
> +
> +       if (need_clear) {
> +               /*
> +                * When we mount with old space cache, we need to
> +                * set BTRFS_DC_CLEAR and set dirty flag.
> +                *
> +                * a) Setting 'BTRFS_DC_CLEAR' makes sure that we
> +                *    truncate the old free space cache inode and
> +                *    setup a new one.
> +                * b) Setting 'dirty flag' makes sure that we flush
> +                *    the new space cache info onto disk.
> +                */
> +               if (btrfs_test_opt(info, SPACE_CACHE))
> +                       cache->disk_cache_state =3D BTRFS_DC_CLEAR;
> +       }
> +       read_extent_buffer(leaf, &cache->item,
> +                          btrfs_item_ptr_offset(leaf, slot),
> +                          sizeof(cache->item));
> +       cache->flags =3D btrfs_block_group_flags(&cache->item);
> +       if (!mixed && ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
> +           (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
> +                       btrfs_err(info,
> +"bg %llu is a mixed block group but filesystem hasn't enabled mixed bloc=
k groups",
> +                                 cache->key.objectid);
> +                       ret =3D -EINVAL;
> +                       goto error;
> +       }
> +
> +       /*
> +        * We need to exclude the super stripes now so that the space inf=
o has
> +        * super bytes accounted for, otherwise we'll think we have more =
space
> +        * than we actually do.
> +        */
> +       ret =3D exclude_super_stripes(cache);
> +       if (ret) {
> +               /* We may have excluded something, so call this just in c=
ase. */
> +               btrfs_free_excluded_extents(cache);
> +               goto error;
> +       }
> +
> +       /*
> +        * Check for two cases, either we are full, and therefore don't n=
eed
> +        * to bother with the caching work since we won't find any space,=
 or we
> +        * are empty, and we can just add all the space in and be done wi=
th it.
> +        * This saves us _a_lot_ of time, particularly in the full case.
> +        */
> +       if (key.offset =3D=3D btrfs_block_group_used(&cache->item)) {
> +               cache->last_byte_to_unpin =3D (u64)-1;
> +               cache->cached =3D BTRFS_CACHE_FINISHED;
> +               btrfs_free_excluded_extents(cache);
> +       } else if (btrfs_block_group_used(&cache->item) =3D=3D 0) {
> +               cache->last_byte_to_unpin =3D (u64)-1;
> +               cache->cached =3D BTRFS_CACHE_FINISHED;
> +               add_new_free_space(cache, key.objectid,
> +                                  key.objectid + key.offset);
> +               btrfs_free_excluded_extents(cache);
> +       }
> +       ret =3D btrfs_add_block_group_cache(info, cache);
> +       if (ret) {
> +               btrfs_remove_free_space_cache(cache);
> +               goto error;
> +       }
> +       trace_btrfs_add_block_group(info, cache, 0);
> +       btrfs_update_space_info(info, cache->flags, key.offset,
> +                               btrfs_block_group_used(&cache->item),
> +                               cache->bytes_super, &space_info);
> +
> +       cache->space_info =3D space_info;
> +
> +       link_block_group(cache);
> +
> +       set_avail_alloc_bits(info, cache->flags);
> +       if (btrfs_chunk_readonly(info, cache->key.objectid)) {
> +               inc_block_group_ro(cache, 1);
> +       } else if (btrfs_block_group_used(&cache->item) =3D=3D 0) {
> +               ASSERT(list_empty(&cache->bg_list));
> +               btrfs_mark_bg_unused(cache);
> +       }
> +       return 0;
> +error:
> +       btrfs_put_block_group(cache);
> +       return ret;
> +}
> +
>  int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  {
>         struct btrfs_path *path;
> @@ -1694,15 +1797,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info *=
info)
>         struct btrfs_block_group_cache *cache;
>         struct btrfs_space_info *space_info;
>         struct btrfs_key key;
> -       struct btrfs_key found_key;
> -       struct extent_buffer *leaf;
>         int need_clear =3D 0;
>         u64 cache_gen;
> -       u64 feature;
> -       int mixed;
> -
> -       feature =3D btrfs_super_incompat_flags(info->super_copy);
> -       mixed =3D !!(feature & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS);
>
>         key.objectid =3D 0;
>         key.offset =3D 0;
> @@ -1726,107 +1822,13 @@ int btrfs_read_block_groups(struct btrfs_fs_info=
 *info)
>                 if (ret !=3D 0)
>                         goto error;
>
> -               leaf =3D path->nodes[0];
> -               btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> -
> -               cache =3D btrfs_create_block_group_cache(info, found_key.=
objectid,
> -                                                      found_key.offset);
> -               if (!cache) {
> -                       ret =3D -ENOMEM;
> -                       goto error;
> -               }
> -
> -               if (need_clear) {
> -                       /*
> -                        * When we mount with old space cache, we need to
> -                        * set BTRFS_DC_CLEAR and set dirty flag.
> -                        *
> -                        * a) Setting 'BTRFS_DC_CLEAR' makes sure that we
> -                        *    truncate the old free space cache inode and
> -                        *    setup a new one.
> -                        * b) Setting 'dirty flag' makes sure that we flu=
sh
> -                        *    the new space cache info onto disk.
> -                        */
> -                       if (btrfs_test_opt(info, SPACE_CACHE))
> -                               cache->disk_cache_state =3D BTRFS_DC_CLEA=
R;
> -               }
> -
> -               read_extent_buffer(leaf, &cache->item,
> -                                  btrfs_item_ptr_offset(leaf, path->slot=
s[0]),
> -                                  sizeof(cache->item));
> -               cache->flags =3D btrfs_block_group_flags(&cache->item);
> -               if (!mixed &&
> -                   ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
> -                   (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
> -                       btrfs_err(info,
> -"bg %llu is a mixed block group but filesystem hasn't enabled mixed bloc=
k groups",
> -                                 cache->key.objectid);
> -                       ret =3D -EINVAL;
> +               btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0=
]);
> +               ret =3D read_one_block_group(info, path, need_clear);
> +               if (ret < 0)
>                         goto error;
> -               }
> -
> -               key.objectid =3D found_key.objectid + found_key.offset;
> +               key.objectid +=3D key.offset;
> +               key.offset =3D 0;
>                 btrfs_release_path(path);
> -
> -               /*
> -                * We need to exclude the super stripes now so that the s=
pace
> -                * info has super bytes accounted for, otherwise we'll th=
ink
> -                * we have more space than we actually do.
> -                */
> -               ret =3D exclude_super_stripes(cache);
> -               if (ret) {
> -                       /*
> -                        * We may have excluded something, so call this j=
ust in
> -                        * case.
> -                        */
> -                       btrfs_free_excluded_extents(cache);
> -                       btrfs_put_block_group(cache);
> -                       goto error;
> -               }
> -
> -               /*
> -                * Check for two cases, either we are full, and therefore
> -                * don't need to bother with the caching work since we wo=
n't
> -                * find any space, or we are empty, and we can just add a=
ll
> -                * the space in and be done with it.  This saves us _a_lo=
t_ of
> -                * time, particularly in the full case.
> -                */
> -               if (found_key.offset =3D=3D btrfs_block_group_used(&cache=
->item)) {
> -                       cache->last_byte_to_unpin =3D (u64)-1;
> -                       cache->cached =3D BTRFS_CACHE_FINISHED;
> -                       btrfs_free_excluded_extents(cache);
> -               } else if (btrfs_block_group_used(&cache->item) =3D=3D 0)=
 {
> -                       cache->last_byte_to_unpin =3D (u64)-1;
> -                       cache->cached =3D BTRFS_CACHE_FINISHED;
> -                       add_new_free_space(cache, found_key.objectid,
> -                                          found_key.objectid +
> -                                          found_key.offset);
> -                       btrfs_free_excluded_extents(cache);
> -               }
> -
> -               ret =3D btrfs_add_block_group_cache(info, cache);
> -               if (ret) {
> -                       btrfs_remove_free_space_cache(cache);
> -                       btrfs_put_block_group(cache);
> -                       goto error;
> -               }
> -
> -               trace_btrfs_add_block_group(info, cache, 0);
> -               btrfs_update_space_info(info, cache->flags, found_key.off=
set,
> -                                       btrfs_block_group_used(&cache->it=
em),
> -                                       cache->bytes_super, &space_info);
> -
> -               cache->space_info =3D space_info;
> -
> -               link_block_group(cache);
> -
> -               set_avail_alloc_bits(info, cache->flags);
> -               if (btrfs_chunk_readonly(info, cache->key.objectid)) {
> -                       inc_block_group_ro(cache, 1);
> -               } else if (btrfs_block_group_used(&cache->item) =3D=3D 0)=
 {
> -                       ASSERT(list_empty(&cache->bg_list));
> -                       btrfs_mark_bg_unused(cache);
> -               }
>         }
>
>         list_for_each_entry_rcu(space_info, &info->space_info, list) {
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
