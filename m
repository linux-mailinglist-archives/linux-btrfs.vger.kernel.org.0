Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB9D114259
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 15:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfLEOKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 09:10:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:51330 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729236AbfLEOKb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 09:10:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07494B189;
        Thu,  5 Dec 2019 14:10:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A1D1EDA733; Thu,  5 Dec 2019 15:10:24 +0100 (CET)
Date:   Thu, 5 Dec 2019 15:10:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
Message-ID: <20191205141024.GP2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-5-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205112706.8125-5-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 07:27:06PM +0800, Anand Jain wrote:
> +static void btrfs_dev_state_to_str(struct btrfs_device *device, char *dev_state_str, size_t n)
> +{
> +	int state;
> +	const char *btrfs_dev_states[] = { "WRITEABLE", "IN_FS_METADATA",
> +					   "MISSING", "REPLACE_TGT", "FLUSHING"
> +					 };
> +
> +	n = n - strlen(dev_state_str) - 1;
> +
> +	for (state = 0; state < ARRAY_SIZE(btrfs_dev_states); state++) {
> +		if (test_bit(state, &device->dev_state)) {
> +			if (strlen(dev_state_str))
> +				strncat(dev_state_str, " ", n);
> +			strncat(dev_state_str, btrfs_dev_states[state], n);
> +		}
> +	}
> +	strncat(dev_state_str, "\n", n);

Please use the snprintf way as in supported_checksums_show and not the
str* functions.
