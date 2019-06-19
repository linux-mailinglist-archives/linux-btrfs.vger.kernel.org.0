Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9644BA7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfFSNvP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 09:51:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:46843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFSNvP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 09:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560952265;
        bh=WXv+Ise/sLefNJua4sa7iRg/vSR/6K8hE14ucg5r4dY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Hh7QQXrETqibPErgYp9WFQKpZOmapQeFJxXSWa7vFFYMWYX/RgSbimW4t1y+D/k/N
         Bc5zPidhRpn2VGRKwkaJrfpl65drQAhcTKJTeGT8C4xplqz/cjZ3bSFxX5q7x9R0Hb
         6fGR+pdmhz5C8X1gRjTVVehWlaCSB2CoaUxPqqIo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYvcA-1i8PWq3Y00-00UviS; Wed, 19
 Jun 2019 15:51:05 +0200
Subject: Re: [PATCH] btrfs: reorder struct btrfs_key for better alignment
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.de>,
        David Sterba <DSterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20190618141514.17322-1-dsterba@suse.com>
 <6ba5daa9-735b-1cdd-fdd7-9c1a60277d46@suse.de>
 <20190619133919.GF8917@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <2f911663-067c-e895-4da5-9fe4b5c1cc35@gmx.com>
Date:   Wed, 19 Jun 2019 21:50:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619133919.GF8917@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9bTzY234sQFpzBvBDZu9PhdEfEJxvYQ3T"
X-Provags-ID: V03:K1:T4pURAvPq9rumMBN4ZQzF2zSa6jrZVamO3ir30HHjVpsRjiXIfM
 tGvqiJfNHTMSIQsIul+u6jYGqca+O9D1Ifdvtgu2K/SbnYhNNPC5BejkZH48xqYTQtXUC0v
 msm5vdhDr1jQGC/ySzCzwx6Dhnk8kFoJeptSHcrD9Ap4Hljq/SO9DJb/l1d7NA5X9EAwoI7
 pWD0CjpC9KgiRVZHQcXyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZQ478kJJ0Hw=:X58W7MdtFC7iWWiShrnsMU
 kwBrsWi35MX2z6eaA76d06No1TDGwXLr0Dq7nNGDPYfgTuQl/9RWfNHofpYhrh8/JPpP54dPv
 T15wo74HtPXbRnPUQEv6s7I6J2S1WrjAKh4Jq3FVn/SsAV9xG5YpzF2rscp5H5dv0Pdu9MJZc
 0MedoRTYYRqtoiQS9ihhxsbqfnwWdOMYKjPVNfxrN5+tviU42eAoGNZMwHL7ebTHeRfpr/CLC
 FpPnEj1BRNI2IpTaMnM9jlXy500IE/JZsjwWUetNaqqUBMrCVywWPy4F2y02J6vIyNZIILANB
 bs3Qff6JgF08XYQTLbT06fJPo0pcnK63nPkqCTxqJt0XL83wTDtD2bf0oVybJjfpNJJJQ29Si
 ExD79c+SLZRzaoHfw6tl8noUSepkqZd7d34au6OBlbKPq+AY5YSpgrWdLjw8zG8h3P7qCYKyr
 ZPbQiw69b/Fdrl6zAb0YyFY2lIN04Xvfnc9kwgsWSlg00+1NTnXW18jO3JSfpqXP7yVqYWiWr
 YWQ8KqyAzskXUS6Y1O2HCZKkvZyiQmMRc9RuvxVqc/ktzwzpFmkDauunaXAQt8n6Tl7u7rUKx
 RQl3M6XDkfaW+/E82SAXib4ukex4UpRo1Y+tY7Z04BEUqflJQrDboSe39PYANdCG8yYbWAYYX
 qmFbMDwWAPHIYXg6MZnXJFU3Y8dGXZvnTrzGRXHbuFPkaWUTM8rLoBOzMh1KKU7hYXLEuAKmn
 wGQ1NRKQBOrV3Ut6UQTH41uwNQ7OyUIQvBcPKS935qRoAH5G1L9lbcwC8d4Bk0Rp+K55MsGb0
 QDWNaxoTRqkIbGiLaj3HkIzYIDtDLLAby6Ac1DvFEnOklgMnyId3o26rivOHdND90UgZxX7+c
 ZlPeo0Fx/Npk3cEC+LOL9lAC4jkHwIsIHaY7kCtiwz8vH663KUEKEIJZbrDxV/d/kIL2AJwDl
 vJwfG7KLqYSX+iuprtMAEDAtbxJ6Xs68=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9bTzY234sQFpzBvBDZu9PhdEfEJxvYQ3T
Content-Type: multipart/mixed; boundary="ejv452sv19SqZ3p5YLm0xn3xeQa7FiT6b";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.de>, David Sterba
 <DSterba@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <2f911663-067c-e895-4da5-9fe4b5c1cc35@gmx.com>
Subject: Re: [PATCH] btrfs: reorder struct btrfs_key for better alignment
References: <20190618141514.17322-1-dsterba@suse.com>
 <6ba5daa9-735b-1cdd-fdd7-9c1a60277d46@suse.de>
 <20190619133919.GF8917@twin.jikos.cz>
In-Reply-To: <20190619133919.GF8917@twin.jikos.cz>

--ejv452sv19SqZ3p5YLm0xn3xeQa7FiT6b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/19 =E4=B8=8B=E5=8D=889:39, David Sterba wrote:
> On Wed, Jun 19, 2019 at 09:37:39AM +0800, Qu Wenruo wrote:
>>>  struct btrfs_key {
>>>  	__u64 objectid;
>>> -	__u8 type;
>>>  	__u64 offset;
>>> +	__u8 type;
>>>  } __attribute__ ((__packed__));
>>
>> And why not remove the packed attribute?
>=20
> Because of this (stack usage changes):

That's expected as long as we're using btrfs_key on stack.

But if we're using btrfs_key on stack and follow the packed feature,
then adjacent on stack memory is not accessed aligned, which could cause
(unobvious) performance drop.

If the unaligned memory access is really causing some performance even
on stack memory, then I'd say the bump in stack memory usage is acceptabl=
e.

If not, then the idea of default -Waddress-of-packed-member makes no sens=
e.

Thanks,
Qu

>=20
> do_relocation                                                      +8 (=
304 -> 312)
> btrfs_orphan_cleanup                                              +16 (=
128 -> 144)
> btrfs_init_new_device                                             -16 (=
288 -> 272)
> get_subvol_name_from_objectid                                      +8 (=
136 -> 144)
> log_conflicting_inodes                                             +8 (=
184 -> 192)
> btrfs_read_chunk_tree                                             +16 (=
128 -> 144)
> btrfs_recover_relocation                                           +8 (=
136 -> 144)
> scrub_stripe                                                      +16 (=
536 -> 552)
> btrfs_clone                                                       +16 (=
352 -> 368)
> free_space_next_bitmap                                             +8 (=
80 -> 88)
> btrfs_find_orphan_roots                                           +16 (=
112 -> 128)
> find_free_dev_extent_start                                         +8 (=
160 -> 168)
> btrfs_lookup_extent_info                                           +8 (=
160 -> 168)
> btrfs_find_item                                                    +8 (=
80 -> 88)
> btrfs_create_pending_block_groups                                  +8 (=
120 -> 128)
> btrfs_read_block_groups                                           -24 (=
176 -> 152)
> __remove_from_free_space_tree                                      +8 (=
120 -> 128)
> check_committed_ref                                                +8 (=
104 -> 112)
> replay_one_buffer                                                  +8 (=
152 -> 160)
> fixup_inode_link_counts                                            +8 (=
96 -> 104)
> btrfs_del_csums                                                    +8 (=
192 -> 200)
> btrfs_search_path_in_tree_user                                    +16 (=
192 -> 208)
> btrfs_lookup_dentry                                                +8 (=
168 -> 176)
> __add_tree_block                                                   +8 (=
120 -> 128)
> __btrfs_balance                                                    +8 (=
264 -> 272)
> __lookup_free_space_inode                                         +16 (=
112 -> 128)
> __readahead_hook                                                  +16 (=
168 -> 184)
> btrfs_get_parent                                                   +8 (=
96 -> 104)
> btrfs_run_dev_replace                                              +8 (=
88 -> 96)
> add_qgroup_item                                                    +8 (=
80 -> 88)
> merge_reloc_root                                                  +16 (=
240 -> 256)
> link_to_fixup_dir                                                  +8 (=
80 -> 88)
> btrfs_insert_orphan_item                                           +8 (=
64 -> 72)
> btrfs_delete_delayed_items                                         +8 (=
184 -> 192)
> btrfs_read_qgroup_config                                           +8 (=
136 -> 144)
> is_extent_unchanged                                                +8 (=
152 -> 160)
> btrfs_recover_log_trees                                           +24 (=
192 -> 216)
> btrfs_create_free_space_tree                                       +8 (=
136 -> 144)
> send_subvol                                                        +8 (=
136 -> 144)
> btrfs_compare_trees                                               +24 (=
176 -> 200)
> get_first_ref                                                      +8 (=
136 -> 144)
> qgroup_trace_new_subtree_blocks                                    +8 (=
176 -> 184)
> qgroup_trace_extent_swap                                          +16 (=
192 -> 208)
> generic_bin_search                                                 +8 (=
160 -> 168)
> replay_one_name                                                    +8 (=
152 -> 160)
> btrfs_print_tree                                                   +8 (=
160 -> 168)
> __create_free_space_inode                                          +8 (=
112 -> 120)
> copy_items                                                        +24 (=
328 -> 352)
> walk_down_reloc_tree                                               +8 (=
160 -> 168)
> btrfs_find_next_key                                                +8 (=
184 -> 192)
> btrfs_del_inode_ref                                                +8 (=
144 -> 152)
> btrfs_check_node                                                  +16 (=
144 -> 160)
> find_next_devid                                                    +8 (=
88 -> 96)
> btrfs_new_inode                                                    +8 (=
184 -> 192)
> __add_to_free_space_tree                                          +16 (=
136 -> 152)
> __btrfs_run_delayed_refs                                           +8 (=
168 -> 176)
> btrfs_qgroup_trace_subtree                                         +8 (=
224 -> 232)
> btrfs_lookup_csums_range                                           +8 (=
184 -> 192)
> __btrfs_update_delayed_inode                                       +8 (=
112 -> 120)
> lookup_inline_extent_backref                                       +8 (=
184 -> 192)
> find_data_references                                               +8 (=
152 -> 160)
> replay_dir_deletes                                                +16 (=
168 -> 184)
> check_leaf                                                         +8 (=
168 -> 176)
> btrfs_ioctl_get_subvol_info                                       +16 (=
128 -> 144)
> btrfs_insert_inode_ref                                             +8 (=
152 -> 160)
> btrfs_finish_sprout                                                +8 (=
152 -> 160)
> build_backref_tree                                                 +8 (=
272 -> 280)
> insert_extent_data_ref                                             +8 (=
96 -> 104)
> send_clone                                                        -24 (=
160 -> 136)
> insert_tree_block_ref                                              +8 (=
56 -> 64)
> read_node_slot                                                     +8 (=
88 -> 96)
> btrfs_csum_file_blocks                                             +8 (=
168 -> 176)
> replace_path                                                      +16 (=
352 -> 368)
> changed_inode                                                     +16 (=
144 -> 160)
> process_all_refs                                                  +16 (=
112 -> 128)
> btrfs_find_root                                                   +16 (=
144 -> 160)
> reada_walk_down                                                    +8 (=
176 -> 184)
> btrfs_insert_xattr_item                                            +8 (=
136 -> 144)
> maybe_send_hole                                                    +8 (=
152 -> 160)
> btrfs_uuid_scan_kthread                                            +8 (=
520 -> 528)
> modify_free_space_bitmap                                           +8 (=
192 -> 200)
> lookup_extent_data_ref                                             +8 (=
144 -> 152)
> btrfs_run_delayed_refs_for_head                                    +8 (=
208 -> 216)
> btrfs_search_dir_index_item                                        +8 (=
112 -> 120)
> btrfs_prev_leaf                                                   +16 (=
88 -> 104)
> may_destroy_subvol                                                 +8 (=
88 -> 96)
> convert_free_space_to_extents                                      +8 (=
176 -> 184)
> btrfs_quota_enable                                                 +8 (=
128 -> 136)
> remove_block_group_free_space                                      +8 (=
120 -> 128)
> __btrfs_drop_extents                                              +24 (=
352 -> 376)
> btrfs_finish_chunk_alloc                                          +16 (=
192 -> 208)
> log_dir_items                                                     +16 (=
192 -> 208)
> btrfs_log_changed_extents                                          +8 (=
240 -> 248)
> update_cache_item                                                  +8 (=
112 -> 120)
> extent_from_logical                                                +8 (=
104 -> 112)
> btrfs_drop_snapshot                                                +8 (=
176 -> 184)
> btrfs_realloc_node                                                 +8 (=
208 -> 216)
> did_create_dir                                                     +8 (=
88 -> 96)
> add_qgroup_relation_item                                           +8 (=
80 -> 88)
> find_dir_range                                                     +8 (=
112 -> 120)
> btrfs_verify_level_key                                             +8 (=
128 -> 136)
> do_walk_down                                                       +8 (=
336 -> 344)
> get_last_extent                                                    +8 (=
88 -> 96)
> add_keyed_refs                                                     +8 (=
168 -> 176)
> read_block_for_search                                              +8 (=
168 -> 176)
> can_rmdir                                                          +8 (=
120 -> 128)
> btrfs_insert_empty_inode                                           +8 (=
40 -> 48)
> btrfs_add_root_ref                                                 +8 (=
144 -> 152)
> __btrfs_free_extent                                                +8 (=
216 -> 224)
> add_all_parents                                                    +8 (=
160 -> 168)
> btrfs_search_path_in_tree                                          +8 (=
120 -> 128)
> add_new_free_space_info                                            +8 (=
72 -> 80)
> btrfs_set_inode_index                                              +8 (=
96 -> 104)
> btrfs_search_forward                                               +8 (=
128 -> 136)
> insert_balance_item                                                +8 (=
232 -> 240)
> btrfs_find_one_extref                                              +8 (=
104 -> 112)
> scrub_raid56_parity                                                +8 (=
400 -> 408)
> btrfs_real_readdir                                                 +8 (=
192 -> 200)
> btrfs_log_inode_parent                                             +8 (=
264 -> 272)
> btrfs_listxattr                                                    +8 (=
168 -> 176)
> convert_free_space_to_bitmaps                                      +8 (=
168 -> 176)
> btrfs_verify_dev_extents                                           +8 (=
152 -> 160)
> find_next_extent                                                   +8 (=
120 -> 128)
> btrfs_set_item_key_safe                                            +8 (=
160 -> 168)
> btrfs_mark_extent_written                                         +16 (=
296 -> 312)
> replay_xattr_deletes                                               +8 (=
192 -> 200)
> caching_kthread                                                    +8 (=
128 -> 136)
> btrfs_remove_chunk                                                 +8 (=
184 -> 192)
> scrub_print_warning_inode                                          +8 (=
208 -> 216)
> caching_thread                                                     +8 (=
184 -> 192)
> log_new_dir_dentries                                              +16 (=
216 -> 232)
> drop_objectid_items                                               +16 (=
112 -> 128)
> insert_dir_log_key                                                 +8 (=
56 -> 64)
> iterate_dir_item                                                   +8 (=
176 -> 184)
> btrfs_lookup_csum                                                  +8 (=
104 -> 112)
> relocate_tree_blocks                                               +8 (=
168 -> 176)
> btrfs_build_ref_tree                                               -8 (=
168 -> 160)
> btrfs_find_highest_objectid                                        +8 (=
80 -> 88)
> btrfs_insert_dir_item                                              +8 (=
136 -> 144)
> walk_down_log_tree                                                 +8 (=
176 -> 184)
> btrfs_insert_file_extent                                           +8 (=
112 -> 120)
> setup_leaf_for_split                                               +8 (=
120 -> 128)
> btrfs_shrink_device                                                +8 (=
176 -> 184)
>=20
> LOST (0):
>=20
> NEW (544):
> 	btrfs_relocate_sys_chunks
> 	find_first_block_group
> 	add_delayed_refs
> 	process_leaf
>=20
> LOST/NEW DELTA:     +544
> PRE/POST DELTA:    +1840
>=20


--ejv452sv19SqZ3p5YLm0xn3xeQa7FiT6b--

--9bTzY234sQFpzBvBDZu9PhdEfEJxvYQ3T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0KPcIACgkQwj2R86El
/qh8agf+P08T46hcUMCkmIHQF7U/FvFyI0ZC5ULIu+IyefFBHIK09iK9DE5eoBqR
m8reRr+7/fJwk284Mw6TNlJNcj2j/ioSjik+AciNXng5P+xOzds8bG6SVr82Q7Wp
JDcttMehI1FViR6W36n8chwoGy0RPUg2uF6Rh+K4x3rAiuTHY0E+nbfTpYoCPQ1G
9VbF9GMTGAbwZWVhpPjb3MtoD9kRp4zqGNPUM1p889GKWplanPceHhsL1Jv/+EHk
tHXEBrmPm/JnzuWNwvPMlmmzrv3WrOq7DZAS8BMsyPTh3PeHgeiUfQMvbxCav04E
CWd9iUoBs5JQi15nPD+6XKfGzLsRBg==
=B6T+
-----END PGP SIGNATURE-----

--9bTzY234sQFpzBvBDZu9PhdEfEJxvYQ3T--
