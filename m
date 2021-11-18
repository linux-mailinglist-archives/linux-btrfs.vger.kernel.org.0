Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6D455AF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 12:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344426AbhKRLyZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 06:54:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34036 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbhKRLx5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 06:53:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CBAE9217BA;
        Thu, 18 Nov 2021 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637236253;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+d5G5sijKDBaXZ6D0Ln7qhwumW8S7LovUaQVxX+TIKU=;
        b=YnFkRxQpNGB6rFqGYqfEdrqH/Nm2CeqzbqfAEDQ1CriVXCIJsm7ExxxZJnxhgKETaLEVCo
        NpHrokCeV/GFgJXuN2mL5nH2ETbJxs35SkttdZ34RWIpMVn0BGkh3sAt3raKSScWbHGXkY
        NU/qKrIMhajD35k1Nxc0socXERBIG3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637236253;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+d5G5sijKDBaXZ6D0Ln7qhwumW8S7LovUaQVxX+TIKU=;
        b=Dvt2nXAlYrUiMJ1vATZ75iJoBIL9kPWwgGUrTlnvQGcU0PPlgDs1qeyiitioecNLQmVt73
        b59Xb4IWQAWJjKDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C3E67A3B85;
        Thu, 18 Nov 2021 11:50:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B022DA735; Thu, 18 Nov 2021 12:50:49 +0100 (CET)
Date:   Thu, 18 Nov 2021 12:50:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 01/25] btrfs: kill BTRFS_FS_BARRIER
Message-ID: <20211118115049.GY28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636144971.git.josef@toxicpanda.com>
 <5ce10de7df0ace8ee6d03d2bd6d8f89d7f2bba11.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce10de7df0ace8ee6d03d2bd6d8f89d7f2bba11.1636144971.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 05, 2021 at 04:45:27PM -0400, Josef Bacik wrote:
> This is no longer used, it's a relic from when we had -o nobarrier.

We still have nobarrier, but it's implemented by the mount option bit
BTRFS_MOUNT_NOBARRIER, I'll update the changelog.
