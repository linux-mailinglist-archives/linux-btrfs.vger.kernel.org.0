Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A61364915
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 19:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhDSRfQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 13:35:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239976AbhDSRfO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 13:35:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDB61B30A;
        Mon, 19 Apr 2021 17:34:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 83FB0DA732; Mon, 19 Apr 2021 19:32:25 +0200 (CEST)
Date:   Mon, 19 Apr 2021 19:32:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] fs/btrfs: Fix uninitialized variable
Message-ID: <20210419173225.GT7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Khaled ROMDHANI <khaledromdhani216@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20210417153616.25056-1-khaledromdhani216@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417153616.25056-1-khaledromdhani216@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 17, 2021 at 04:36:16PM +0100, Khaled ROMDHANI wrote:
> As reported by the Coverity static analysis.
> The variable zone is not initialized which
> may causes a failed assertion.
> 
> Addresses-Coverity: ("Uninitialized variables")
> Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> ---
> v2: add a default case as proposed by David Sterba
> ---
>  fs/btrfs/zoned.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index eeb3ebe11d7a..82527308d165 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -143,6 +143,9 @@ static inline u32 sb_zone_number(int shift, int mirror)
>  	case 0: zone = 0; break;
>  	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
>  	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
> +	default:
> +		zone = 0;

Well yeah but this is not a valid case at all, we'd rather catch that as
an assertion failure than letting is silently continue.
