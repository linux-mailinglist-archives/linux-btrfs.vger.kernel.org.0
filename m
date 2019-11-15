Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4BEDFE21D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfKOP6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 10:58:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:49750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbfKOP6P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 10:58:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25FEEBA37;
        Fri, 15 Nov 2019 15:58:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0BCD4DA7D3; Fri, 15 Nov 2019 16:58:16 +0100 (CET)
Date:   Fri, 15 Nov 2019 16:58:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1.1 04/18] btrfs-progs: add global verbose and quiet
 options and helper functions
Message-ID: <20191115155816.GX3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
 <1572849196-21775-5-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572849196-21775-5-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 04, 2019 at 02:33:02PM +0800, Anand Jain wrote:
> +		case 'v':
> +			bconf.verbose < 0 ? bconf.verbose = 1 : bconf.verbose++;

This code gets repeated and it's not IMO simple enough to be copy-pasted
around. Eg. bconf_be_verbose() and eventually bconf_be_quiet().

> +			break;
> +		case 'q':
> +			bconf.verbose = 0;
> +			break;
>  		default:
>  			fprintf(stderr, "Unknown global option: %s\n",
>  					argv[optind - 1]);
> --- a/common/help.h
> +++ b/common/help.h
> @@ -53,6 +53,17 @@
>  	"-t|--tbytes        show sizes in TiB, or TB with --si"
>  
>  /*
> + * Global verbose option for the sub-commands
> + */
> +#define HELPINFO_GLOBAL_OPTIONS_HEADER						\
> +	"",									\
> +	"Global options:"
> +#define HELPINFO_INSERT_VERBOSE							\
> +	"-v|--verbose       show verbose output"

                            increase output verbosity

> +#define HELPINFO_INSERT_QUIET							\
> +	"-q|--quiet         run the command quietly"

			    print only errors
> +
> +/*
>   * Special marker in the help strings that will preemptively insert the global
>   * options and then continue with the following text that possibly follows
>   * after the regular options
> --- a/common/utils.h
> +++ b/common/utils.h
> @@ -122,6 +122,9 @@ void print_all_devices(struct list_head *devices);
>   */
>  struct btrfs_config {
>  	unsigned int output_format;
> +
> +	/* -1:unset 0:quiet >0:verbose */

Instead of the constants, please add some defines for the unset and
default states. Maybe also for quiet.

> +	int verbose;
>  };
>  extern struct btrfs_config bconf;
