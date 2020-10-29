Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806F329F217
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 17:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgJ2Qsv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 12:48:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:48660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgJ2QrO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 12:47:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02423AD66;
        Thu, 29 Oct 2020 16:47:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 38B0CDA7CE; Thu, 29 Oct 2020 17:45:36 +0100 (CET)
Date:   Thu, 29 Oct 2020 17:45:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 3/3] btrfs: create read policy sysfs attribute, pid
Message-ID: <20201029164535.GO6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <cover.1603884513.git.anand.jain@oracle.com>
 <52a41497534bdaa301adc57d61ea3632ab65f2c6.1603884513.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a41497534bdaa301adc57d61ea3632ab65f2c6.1603884513.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 28, 2020 at 09:14:47PM +0800, Anand Jain wrote:
> +static ssize_t btrfs_read_policy_store(struct kobject *kobj,
> +				       struct kobj_attribute *a,
> +				       const char *buf, size_t len)
> +{
> +	int i;
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
> +
> +	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
> +		if (btrfs_strmatch(buf, btrfs_read_policy_name[i])) {

Does sysfs guarantee that the buf is nul terminated string or that it
contains a null at all? Because if not, the skip_space step of strmatch
could run out of the buffer.
