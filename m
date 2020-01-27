Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFB114A5F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 15:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgA0OYh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 09:24:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:53246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgA0OYh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 09:24:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 97474ABED;
        Mon, 27 Jan 2020 14:24:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 23ADEDA730; Mon, 27 Jan 2020 15:24:17 +0100 (CET)
Date:   Mon, 27 Jan 2020 15:24:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 5/5] VERSION: bump version
Message-ID: <20200127142416.GS3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200127024954.16916-1-marcos.souza.org@gmail.com>
 <20200127024954.16916-5-marcos.souza.org@gmail.com>
 <7987441f-c3a0-0d41-45c0-94ebdc17d70a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7987441f-c3a0-0d41-45c0-94ebdc17d70a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 27, 2020 at 10:50:15AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/1/27 上午10:49, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > As a new symbol was created, bump the library version.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> That's David's work. Please leave the honor work for David.

Yeah that's for the whole progs release. The version increase of the
libraries is done in configure.ac and libbtrfsutil/btrfsutil.h
