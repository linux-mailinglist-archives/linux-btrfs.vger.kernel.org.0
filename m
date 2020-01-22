Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA9414590D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 16:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgAVPwl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 10:52:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:42530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVPwk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 10:52:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 59156B2CC;
        Wed, 22 Jan 2020 15:52:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F0E7DA738; Wed, 22 Jan 2020 16:52:23 +0100 (CET)
Date:   Wed, 22 Jan 2020 16:52:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sebastian =?iso-8859-1?Q?D=F6ring?= <moralapostel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs scrub: cancel + resume not resuming?
Message-ID: <20200122155223.GB3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sebastian =?iso-8859-1?Q?D=F6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CADkZQakAhrRHFeHPJfne5oLT81qFGbzNAiUoqb3r0cxVSuHTNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkZQakAhrRHFeHPJfne5oLT81qFGbzNAiUoqb3r0cxVSuHTNg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 09, 2020 at 11:03:08AM +0100, Sebastian Döring wrote:
> Maybe I'm doing it entirely wrong, but I can't seem to get 'btrfs
> scrub resume' to work properly. During a running scrub the resume
> information (like data_bytes_scrubbed:1081454592) gets written to a
> file in /var/lib/btrfs, but as soon as the scrub is cancelled all
> relevant fields are zeroed. 'btrfs scrub resume' then seems to
> re-start from the very beginning.

For the record, fix is queued for stable 5.4.14. Thanks for the report.
