Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B7A34A8F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 14:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCZNuC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 09:50:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:33426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhCZNtl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 09:49:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F6D6AB8A;
        Fri, 26 Mar 2021 13:49:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 16AC6DA734; Fri, 26 Mar 2021 14:47:33 +0100 (CET)
Date:   Fri, 26 Mar 2021 14:47:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] btrfs: Fix a typo
Message-ID: <20210326134732.GN7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210326005932.8238-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326005932.8238-1-unixbhaskar@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 26, 2021 at 06:29:32AM +0530, Bhaskar Chowdhury wrote:
> 
> s/reponsible/responsible/

So this is exactly what I don't want to see happen - one patch per typo.
I tried to explain it in the previous patch, please either fix all typos
under fs/btrfs or don't bother.
