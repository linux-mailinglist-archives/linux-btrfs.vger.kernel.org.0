Return-Path: <linux-btrfs+bounces-1057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D481873F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 13:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E591F24017
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 12:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5FE18E13;
	Tue, 19 Dec 2023 12:16:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5AC18640;
	Tue, 19 Dec 2023 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 01BCC68BFE; Tue, 19 Dec 2023 13:16:49 +0100 (CET)
Date: Tue, 19 Dec 2023 13:16:49 +0100
From: "hch@lst.de" <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Ed Tsai =?utf-8?B?KOiUoeWul+i7kik=?= <Ed.Tsai@mediatek.com>,
	"Naohiro.Aota@wdc.com" <Naohiro.Aota@wdc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Chun-Hung Wu =?utf-8?B?KOW3q+mnv+Wujyk=?= <Chun-hung.Wu@mediatek.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Subject: Re: [PATCH 3/5] block: remove support for the host aware zone model
Message-ID: <20231219121649.GA21736@lst.de>
References: <20231217165359.604246-1-hch@lst.de> <20231217165359.604246-4-hch@lst.de> <b4d33dc359495c6227a3f20285566eed27718a14.camel@mediatek.com> <190f58f7-2ed6-46f8-af59-5e167a0bddeb@kernel.org> <f19c41b9ea990e6da734b6c81caeebb73fb60b29.camel@mediatek.com> <do3ekgymdpa4skyz5p3dp6qcqq7zuty73qrpmftszmffunnxpm@fyswyalaxzfq> <dbc4a5b4296effd88ba0ef939aa324df0969545c.camel@mediatek.com> <0a329050-0010-47cb-8c7b-a2f0863a21e8@kernel.org> <20231219103825.GB14379@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219103825.GB14379@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 19, 2023 at 11:38:25AM +0100, hch@lst.de wrote:
> > > It's very minor, so is okay to ignore my preference.
> > 
> > Send a patch on top of Christoph's series if you want to clean this up.
> 
> I'll need to respin anyway, so I'll look into incorporating the
> suggestion.

I did look into it and the iterate callbacks confuse the heck out of me.
So I'm not going to touch them in non-trivial ways here and will leave
it for follow on cleanups as needed.

