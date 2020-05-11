Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29251CDB0E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 15:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgEKNS3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 09:18:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:52762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgEKNS3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 09:18:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ECFCEAFCE;
        Mon, 11 May 2020 13:18:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7E122DA823; Mon, 11 May 2020 15:17:36 +0200 (CEST)
Date:   Mon, 11 May 2020 15:17:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/19] btrfs: speed up btrfs_set_token_##bits helpers
Message-ID: <20200511131736.GR18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1588853772.git.dsterba@suse.com>
 <fafa95a12439369c9e6b323f3c46bbfad9efac1c.1588853772.git.dsterba@suse.com>
 <SN4PR0401MB3598C61E83CACAB99C7C44D69BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598C61E83CACAB99C7C44D69BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 08, 2020 at 01:50:52PM +0000, Johannes Thumshirn wrote:
> On 07/05/2020 22:21, David Sterba wrote:
> > This is all wasteful. We know the number of bytes to read, 1/2/4/8 and
> 
> Same question, s/read/write/?

Yes, fixed, thanks.
