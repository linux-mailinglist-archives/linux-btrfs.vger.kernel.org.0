Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415FA752B92
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 22:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjGMUWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 16:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGMUWT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 16:22:19 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E595F2709
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:22:16 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57a6df91b1eso10847777b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689279736; x=1691871736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qbwqhr61Qu4vYXX/+8eQna60L/FNKs9bg6qISicdV6A=;
        b=yMf3OWuNgNn0Cid/qpuFL7x0TMyg3Hoaq6pmzzYuIyifZrumgcV7MLMEg2QU7S6QA4
         Yg8UzHN/vt6aouol28dD/GbBC6Tdie9K858ZxMsGa0m5Aupb8fFTzStywwIYN7I5Y1lM
         +sPBTuOYBIDFJL/Bo5O7dyy7J3RAm9TfcpHTpkdxGb5UKXFKl7tQDzXo23H+aZ/AZTH6
         iN/zjPFI5FArJZj3Zxaf4dbi/PEkucOAMEv3lk16szDYHzeiup5ejbn2db4mihuNKkFW
         6+NsX31bOL9wRLUnGhG/Tu/47/RqyHS516/pgmYskUu8w1RTVJSOOk6KRxWFwQi9qvlm
         XdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279736; x=1691871736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbwqhr61Qu4vYXX/+8eQna60L/FNKs9bg6qISicdV6A=;
        b=a4rohcIhQ8cPo50qM6O+ZrgKNeuxL8bqxheCoURKg36If2ty94WBaSbQj61o/ExfyK
         Qrf32qbJ/dBg3VNaw2/UuwnYx9m9C0fcRlSWqrqhTQNla2hWuL+ysuqKSyqNbxyUCkYF
         PrGMhFI9fpAt7/n9Vv2biou8H2SzWuX+8xbTMKBahTJOYEqZyoIoZfepQRMdQhXqiPM2
         A6bWdalcf1wwb5bNuG4nbHICw4pkcwzqMhBPASFcPayUOCXx2IdzsR2n4FJypciHoDme
         jlh7pwNyTq9nIg3w/BbwG0KWcxoVb/b2HXIYeF5cjntRYhUaWxbE+FhXjbu7elDRXTDp
         NmIQ==
X-Gm-Message-State: ABy/qLY+UTyBKq6eKW7mrr3Cj86F4dL/cIMmYgACTcKp3MceLxb5/oFR
        jTWp7AV0Lw2UrEdAtHccuQS+URj36GLP5SsDq/h3nQ==
X-Google-Smtp-Source: APBJJlGAAxCr8CHr3jjJKquJ8jXxRWMkF50xwf4D96uzhMQr9+2yMea68ivnETC4B2mO3KwgrArZGA==
X-Received: by 2002:a0d:db11:0:b0:576:916d:964 with SMTP id d17-20020a0ddb11000000b00576916d0964mr3001321ywe.20.1689279735868;
        Thu, 13 Jul 2023 13:22:15 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e1-20020a0df501000000b0057085b18cddsm1950996ywf.54.2023.07.13.13.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:22:15 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:22:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/8] btrfs-progs: simple quotas fsck
Message-ID: <20230713202214.GV207541@perftesting>
References: <cover.1688599734.git.boris@bur.io>
 <929adaf2889519f82cb79db3077eef2d8938a247.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <929adaf2889519f82cb79db3077eef2d8938a247.1688599734.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:36:23PM -0700, Boris Burkov wrote:
> Add simple quotas checks to btrfs check.
> 
> Like the kernel feature, these checks bypass most of the backref walking
> in the qgroups check. Instead, they enforce the invariant behind the
> design of simple quotas by scanning the extent tree and determining the
> owner of each extent:
> Data: reading the owner ref inline item
> Metadata: reading the tree block and reading its btrfs_header's owner
> 
> This gives us the expected count from squotas which we check against the
> on-disk state of the qgroup items
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  check/main.c          |   2 +
>  check/qgroup-verify.c | 122 ++++++++++++++++++++++++++++++++++--------
>  2 files changed, 102 insertions(+), 22 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 77bb50a0e..07f31fbe0 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -5667,6 +5667,8 @@ static int process_extent_item(struct btrfs_root *root,
>  					btrfs_shared_data_ref_count(eb, sref),
>  					gen, 0, num_bytes);
>  			break;
> +		case BTRFS_EXTENT_OWNER_REF_KEY:
> +			break;
>  		default:
>  			fprintf(stderr,
>  				"corrupt extent record: key [%llu,%u,%llu]\n",
> diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
> index 1a62009b8..0d079f3b7 100644
> --- a/check/qgroup-verify.c
> +++ b/check/qgroup-verify.c
> @@ -85,6 +85,8 @@ static struct counts_tree {
>  	unsigned int		num_groups;
>  	unsigned int		rescan_running:1;
>  	unsigned int		qgroup_inconsist:1;
> +	unsigned int        simple:1;
> +	u64         enable_gen;
>  	u64			scan_progress;
>  } counts = { .root = RB_ROOT };
>  
> @@ -341,14 +343,14 @@ static int find_parent_roots(struct ulist *roots, u64 parent)
>  	ref = find_ref_bytenr(parent);
>  	if (!ref) {
>  		error("bytenr ref not found for parent %llu",
> -				(unsigned long long)parent);
> +		      (unsigned long long)parent);
>  		return -EIO;
>  	}
>  	node = &ref->bytenr_node;
>  	if (ref->bytenr != parent) {
>  		error("found bytenr ref does not match parent: %llu != %llu",
> -				(unsigned long long)ref->bytenr,
> -				(unsigned long long)parent);
> +		      (unsigned long long)ref->bytenr,
> +		      (unsigned long long)parent);
>  		return -EIO;
>  	}
>  
> @@ -364,8 +366,8 @@ static int find_parent_roots(struct ulist *roots, u64 parent)
>  			prev = rb_entry(prev_node, struct ref, bytenr_node);
>  			if (prev->bytenr == parent) {
>  				error(
> -				"unexpected: prev bytenr same as parent: %llu",
> -						(unsigned long long)parent);
> +				      "unexpected: prev bytenr same as parent: %llu",
> +				      (unsigned long long)parent);
>  				return -EIO;
>  			}
>  		}
> @@ -717,9 +719,6 @@ static int travel_tree(struct btrfs_fs_info *info, struct btrfs_root *root,
>  	u64 new_bytenr;
>  	u64 new_num_bytes;
>  
> -//	printf("travel_tree: bytenr: %llu\tnum_bytes: %llu\tref_parent: %llu\n",
> -//	       bytenr, num_bytes, ref_parent);
> -

Don't make big formatting changes with code changes, it makes it hard to tell
what's important and what I can gloss over.  Thanks,

Josef
