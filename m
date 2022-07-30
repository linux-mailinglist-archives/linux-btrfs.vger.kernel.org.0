Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84F5585B0C
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jul 2022 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiG3Pjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Jul 2022 11:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiG3Pjs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Jul 2022 11:39:48 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 Jul 2022 08:39:46 PDT
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C5A60D5
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Jul 2022 08:39:46 -0700 (PDT)
Received: from [192.168.1.27] ([84.222.35.163])
        by smtp-16.iol.local with ESMTPA
        id HoY7odIeJnJ6yHoY7o0pZD; Sat, 30 Jul 2022 17:38:43 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1659195523; bh=9QJas9TxEO+XTESSIqvDhQ6ehmTkgcLVumR+Vp+6tTQ=;
        h=From;
        b=N/bNYIqZ1ZqenZKjlkQ0TYW9kwiKtEBkXiIfQI0ZEykCgkcwk7TdAwNHITUrWxrnU
         D0Ol45HcebjVcfl44YZkJFPQfXz1UL3Po5fzE8NtoNTg20Ao2220hpGcgxelLvyOkS
         KB/K0M7wDxZJbjJagKncNTN7I9STyyKSdhUdE6WsZWV/9QvkNYgsgM8KZ30hN1mRab
         bqLC3dKiT8/GwmgQZ/ck19JssmxiQ+kU+Wy+iHyDHEEMfDqJTL7OPgB2zyrKfsoO53
         LZk+vTkmbBpXwxFa5Uy171jCvErbgxzLoFsQd4Wf3gc49ts8FQnUXzJVByfqHS+Iao
         uh5svuuSkp7kQ==
X-CNFS-Analysis: v=2.4 cv=E9MIGYRl c=1 sm=1 tr=0 ts=62e55083 cx=a_exe
 a=FwZ7J7/P4KMHneBNQvmhbg==:117 a=FwZ7J7/P4KMHneBNQvmhbg==:17
 a=IkcTkHD0fZMA:10 a=9gYKjKy2mr5dGOMv2I8A:9 a=QEXdDO2ut3YA:10
Message-ID: <c2e7bd2e-e317-4741-5522-d7a311f5ff70@libero.it>
Date:   Sat, 30 Jul 2022 17:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Reply-To: kreijack@inwind.it
Subject: Re: How to get the lsit of subvolumes with
 btrfs_util_create_subvolume_iterator
Content-Language: en-US
To:     Pierre Couderc <pierre@couderc.eu>, linux-btrfs@vger.kernel.org
References: <6a22d8d1-f11e-e37e-3d37-1ab28d0235eb@couderc.eu>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <6a22d8d1-f11e-e37e-3d37-1ab28d0235eb@couderc.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDurVTa+K3h1gfvBMoo8kd31LFLDenhO22d5CsZR5p7b4Ur1KQhx74SD09l6xsO7ryu9ZJwZ3rJw1ssQTATbo9pIpcdlP5dG1VuMkGw0E1Y5VtvHfUEb
 Hy3+ZxRT1h0tTqZDnmKYytVIRz6njmQM63suOLgqMRaSi+zxmYQLj/IkLBWihSDUkKMZEmvW8zlnBjAhEA5vDc0ZNcbPEhE9ntC5iVizz2q5ipFpcsjW3Y3b
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/07/2022 17.01, Pierre Couderc wrote:
> btrfs_util_create_subvolume_iterator("/",0, 0, &iter);


 From the btrfs header "./libbtrfsutil/btrfsutil.h"

<----- cut ---------->
/**
  * BTRFS_UTIL_SUBVOLUME_ITERATOR_POST_ORDER - Iterate post-order. The default
  * behavior is pre-order, e.g., foo will be yielded before foo/bar. If this flag
  * is specified, foo/bar will be yielded before foo.
  */
#define BTRFS_UTIL_SUBVOLUME_ITERATOR_POST_ORDER (1 << 0)
#define BTRFS_UTIL_SUBVOLUME_ITERATOR_MASK ((1 << 1) - 1)

/**
  * btrfs_util_create_subvolume_iterator() - Create an iterator over subvolumes
  * in a Btrfs filesystem.
  * @path: Path in a Btrfs filesystem. This may be any path in the filesystem; it
  * does not have to refer to a subvolume unless @top is zero.
  * @top: List subvolumes beneath (but not including) the subvolume with this ID.
  * If zero is given, the subvolume ID of @path is used. To list all subvolumes,
  * pass %BTRFS_FS_TREE_OBJECTID (i.e., 5). The returned paths are relative to
  * the subvolume with this ID.
  * @flags: Bitmask of BTRFS_UTIL_SUBVOLUME_ITERATOR_* flags.
  * @ret: Returned iterator.
  *
  * Subvolume iterators require appropriate privilege (CAP_SYS_ADMIN) unless @top
  * is zero and the kernel supports BTRFS_IOC_GET_SUBVOL_ROOTREF and
  * BTRFS_IOC_INO_LOOKUP_USER (kernel >= 4.18). In this case, subvolumes which
  * cannot be accessed (e.g., due to permissions or other mounts) will be
  * skipped.
  *
  * The returned iterator must be freed with
  * btrfs_util_destroy_subvolume_iterator().
  *
  * Return: %BTRFS_UTIL_OK on success, non-zero error code on failure.
  */
enum btrfs_util_error btrfs_util_create_subvolume_iterator(const char *path,
                                                            uint64_t top,
                                                            int flags,
                                                            struct btrfs_util_subvolume_iterator **ret);


<----- cut ---------->

It would be useful knowing what btrfs_util_create_subvolume_iterator() value returns,
and how you iterate over the subvolumes.

I suggest to give a look to the cmd_subvol_show() functions about use "btrfs_util_create_subvolume_iterator()"

> 
> gives me an empty list !!!
> 
> What do I miss ?
> 
> What is top ? 0?
> 
> What is flag ? what is BTRFS_UTIL_SUBVOLUME_ITERATOR_POST_ORDER ?
> 
> I just want the list of all subvolumes...
> 
> Thanks
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

