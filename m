Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6D8401D3C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 16:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbhIFOrf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 10:47:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37032 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbhIFOrf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 10:47:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 95E5D22151;
        Mon,  6 Sep 2021 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630939589;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1UL92Y37loAZaIjRBtQCJ/RggAsFZ3H1J+BHML5dvpY=;
        b=s067OUcAM04kx0Hl/ZfX8GpkTKL5nr0GfDhw8uXz7onG2A9i7a08MbO/UJpYSWMJmYqdhQ
        BZ7KT6t32W7yF+7IEDVxHGAwGG1udWzhC3nTZbaOE+Zvo1NKJlO/88KHe7GDHDboC7zAzg
        4dmiLjUfTYwrVhKRZtAvzVD1jNU4QmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630939589;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1UL92Y37loAZaIjRBtQCJ/RggAsFZ3H1J+BHML5dvpY=;
        b=eimYqE0owEp7H9NRXXx7HhLZD5lK1h4lfK1LBXkRTIl+YVrOtBpfJ6GsCvS4SjToT9zl10
        XtAVF/tQu4s4dcAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8F206A3B88;
        Mon,  6 Sep 2021 14:46:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A9C6DA781; Mon,  6 Sep 2021 16:46:26 +0200 (CEST)
Date:   Mon, 6 Sep 2021 16:46:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: use btrfs_key for btrfs_check_node()
 and btrfs_check_leaf()
Message-ID: <20210906144626.GI3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210902130843.120176-1-wqu@suse.com>
 <20210902130843.120176-2-wqu@suse.com>
 <4cebfa71-59cb-fa71-d9aa-a3707778cc0c@suse.com>
 <6bc4fb68-8e79-9c1f-af63-d4d2858dc0c2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bc4fb68-8e79-9c1f-af63-d4d2858dc0c2@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 04, 2021 at 01:06:10PM +0800, Qu Wenruo wrote:
> >> -            btrfs_disk_key_to_cpu(&cpukey, parent_key);
> >> +            memcpy(&key, parent_key, sizeof(struct btrfs_key));
> >>           else
> >> -            btrfs_item_key_to_cpu(buf, &cpukey, 0);
> >> +            btrfs_item_key_to_cpu(buf, &key, 0);
> >> -        btrfs_add_corrupt_extent_record(fs_info, &cpukey,
> >> +        btrfs_add_corrupt_extent_record(fs_info, &key,
> >>                           buf->start, buf->len, 0);
> >>       }
> >>       return ret;
> >> @@ -705,22 +710,21 @@ fail:
> >>   static int noinline check_block(struct btrfs_fs_info *fs_info,
> >>                   struct btrfs_path *path, int level)
> >>   {
> >> -    struct btrfs_disk_key key;
> >> -    struct btrfs_disk_key *key_ptr = NULL;
> >> -    struct extent_buffer *parent;
> >> +    struct btrfs_key key;
> >> +    struct btrfs_key *parent_key_ptr;
> > 
> > This is the cause of fsck tests failure.
> > 
> > @parent_key_ptr is not initialized, but I'm also wondering why compiler 
> > is not slapping a big warning onto my face.
> 
> Not sure why but neither clang 12.0.1 nor 11.1.0 gives me any warning on 
> the uninitialized pointer, even if -Wuninitialized is specified.
> 
> Any idea/suggestion to detect such uninitialized pointer?

My best guess is that the stack variables are implicitly initialized to
zero and there are checks inside the functions, and this somehow tells
the compiler not to report it as uninitialized. I'm running 11.1.1 and
don't see any warning with our without -Wuninitialized.
