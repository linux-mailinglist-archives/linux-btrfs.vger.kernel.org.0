Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F419829409E
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 18:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394718AbgJTQes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 12:34:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:58468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394719AbgJTQes (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 12:34:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56230AC48;
        Tue, 20 Oct 2020 16:34:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32BEFDA7C5; Tue, 20 Oct 2020 18:33:17 +0200 (CEST)
Date:   Tue, 20 Oct 2020 18:33:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v4 8/8] btrfs: introduce rescue=all
Message-ID: <20201020163317.GB6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
References: <cover.1602862052.git.josef@toxicpanda.com>
 <30396ee8e71dbcd707c84046917a6e378c89fd98.1602862052.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30396ee8e71dbcd707c84046917a6e378c89fd98.1602862052.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 16, 2020 at 11:29:20AM -0400, Josef Bacik wrote:
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -362,6 +362,7 @@ enum {
>  	Opt_nologreplay,
>  	Opt_ignorebadroots,
>  	Opt_ignoredatacsums,
> +	Opt_all,
>  
>  	/* Deprecated options */
>  	Opt_recovery,
> @@ -461,6 +462,7 @@ static const match_table_t rescue_tokens = {
>  	{Opt_ignorebadroots, "ibadroots"},
>  	{Opt_ignoredatacsums, "ignoredatacsums"},
>  	{Opt_ignoredatacsums, "idatacsums"},
> +	{Opt_all, "all"},

The way the sysfs supported_rescue_options works right now it also
prints 'all':

  # cat supported_rescue_options
  usebackuproot nologreplay ignorebadroots ignoredatacsums all

It's not wrong just that I did not expect to see it there, let's keep it.
