Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD91360EA
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfFEQNa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 12:13:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:57168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728421AbfFEQNa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 12:13:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABAA4AF8E
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2019 16:13:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B3E7DDA866; Wed,  5 Jun 2019 18:14:20 +0200 (CEST)
Date:   Wed, 5 Jun 2019 18:14:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: tests: Test fs on image files is
 correctly recognised
Message-ID: <20190605161419.GD9896@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190516131250.26621-1-nborisov@suse.com>
 <20190516131250.26621-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516131250.26621-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 16, 2019 at 04:12:50PM +0300, Nikolay Borisov wrote:
> This ensures that 'btrfs filesystem show' can correctly identify a
> filesystem on a newly created local file.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  tests/cli-tests/010-fi-show-on-new-file/test.sh | 16 ++++++++++++++++

Test is ok, the placment should be to misc-tests, cli-tests is really to
verify that argumets get parsed and that some combinations are handled.
