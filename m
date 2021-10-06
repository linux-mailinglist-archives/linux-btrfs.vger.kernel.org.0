Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27B54239B7
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 10:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbhJFI0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 04:26:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45020 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbhJFI0k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 04:26:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3DED22487;
        Wed,  6 Oct 2021 08:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633508687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUdkZFEVAvHYTqm6h64ZGPuXCAZd9fKcybRVntXTQdY=;
        b=dquAGo7radPoIz++pDlWF+NDDlOXmJ9q/qhFQZjDht5mWuT2noRbFKigxNUmj/FYc5ZDbf
        tQhpv66cpobwoGtApPvro5iLCDrvFrk3RMhhCHM7WWMdux1b8O3Pr+9eESwV2pmNidZGqJ
        D8HtnrTfQhkO7cl4bX26O7354xtvzGQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF00A13E19;
        Wed,  6 Oct 2021 08:24:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tygpKE9dXWG9KgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 06 Oct 2021 08:24:47 +0000
Subject: Re: [PATCH v4 5/6] btrfs: add a btrfs_get_dev_args_from_path helper
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633464631.git.josef@toxicpanda.com>
 <b8fd2ecac3156cb0ea8d717f481182b25dce8841.1633464631.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7a313008-320d-4e1c-e90a-08c04161d354@suse.com>
Date:   Wed, 6 Oct 2021 11:24:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b8fd2ecac3156cb0ea8d717f481182b25dce8841.1633464631.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.10.21 г. 23:12, Josef Bacik wrote:
> We are going to want to populate our device lookup args outside of any
> locks and then do the actual device lookup later, so add a helper to do
> this work and make btrfs_find_device_by_devspec() use this helper for
> now.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
