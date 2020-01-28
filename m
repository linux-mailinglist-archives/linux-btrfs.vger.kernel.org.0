Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E901D14BE9A
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 18:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA1Rbt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 12:31:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:48012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1Rbt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 12:31:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DF7BDAEE0;
        Tue, 28 Jan 2020 17:31:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 19917DA730; Tue, 28 Jan 2020 18:31:29 +0100 (CET)
Date:   Tue, 28 Jan 2020 18:31:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Craig Andrews <candrews@integralblue.com>
Cc:     fdmanana@gmail.com,
        =?iso-8859-1?Q?St=E9phane?= Lesimple 
        <stephane_btrfs2@lesimple.fr>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Regression in Linux 5.5.0-rc[1-5]: btrfs send/receive out of
 memory
Message-ID: <20200128173128.GB3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Craig Andrews <candrews@integralblue.com>, fdmanana@gmail.com,
        =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs2@lesimple.fr>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
 <20200113133741.GU3929@twin.jikos.cz>
 <7e7e4f63a89b6bb8a270d4c4ec676835@integralblue.com>
 <8254df450ca61dd4cbc455f19ee28c01@lesimple.fr>
 <CAL3q7H4-3Mg2GUf2JMMFem77sSQR5opN9dxdvHz2kk1Qd=RD=A@mail.gmail.com>
 <06639bb0a512aff6ed8a41bffb033f35@integralblue.com>
 <CAL3q7H5FHc9ooNOP3CnXas=_H_BEZN5mzegVMuvtoXgT9nxL6A@mail.gmail.com>
 <f2ca887d98c1b5aacc4dde88cba74d98@integralblue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ca887d98c1b5aacc4dde88cba74d98@integralblue.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 28, 2020 at 10:05:37AM -0500, Craig Andrews wrote:
> Can you please send the reply?
> Tested-by: Craig Andrews <candrews@integralblue.com>

Thanks for the report and testing! As the patch is a fix it will go to
mainline soon and then it'll propagate to stable trees, 5.4 and 5.5.
