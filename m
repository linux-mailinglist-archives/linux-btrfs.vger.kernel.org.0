Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 995A4EB778
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 19:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfJaSop (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 14:44:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:42508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729289AbfJaSop (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 14:44:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E13FB3F9;
        Thu, 31 Oct 2019 18:44:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BFFDCDA783; Thu, 31 Oct 2019 19:44:53 +0100 (CET)
Date:   Thu, 31 Oct 2019 19:44:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/4] RAID1 with 3- and 4- copies
Message-ID: <20191031184453.GG3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1572534591.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572534591.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kernel code can be pulled from (based on misc-next)

  git://github.com/kdave/btrfs-devel.git dev/raid1c3-5.5-final

and for btrfs-progs (based on 5.3.1)

  git://github.com/kdave/btrfs-progs.git dev/raid1c34
