Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C08216C3FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 15:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgBYOe0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 09:34:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:44450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbgBYOe0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 09:34:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4F52CB1C3;
        Tue, 25 Feb 2020 14:34:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2ECCDA726; Tue, 25 Feb 2020 15:34:04 +0100 (CET)
Date:   Tue, 25 Feb 2020 15:34:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 00/21] btrfs: refactor and generalize
 chunk/dev_extent/extent allocation
Message-ID: <20200225143404.GF2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Tue, Feb 25, 2020 at 12:56:05PM +0900, Naohiro Aota wrote:
> This series refactors chunk allocation, device_extent allocation and
> extent allocation functions and make them generalized to be able to
> implement other allocation policy easily.

I went through the patches and haven't seen anything serious so will do
another pass and then move it to misc-next as it's all a fairly
straightforward.
