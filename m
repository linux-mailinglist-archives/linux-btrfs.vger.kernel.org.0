Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B94D6910
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 20:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbfJNSD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 14:03:29 -0400
Received: from p3nlsmtpcp01-02.prod.phx3.secureserver.net ([184.168.200.140]:47852
        "EHLO p3nlsmtpcp01-02.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbfJNSD3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 14:03:29 -0400
Received: from p3plcpnl0639.prod.phx3.secureserver.net ([50.62.176.166])
        by : HOSTING RELAY : with ESMTP
        id K4fsiNY3L9G9cK4fsiCpa2; Mon, 14 Oct 2019 11:02:28 -0700
Received: from [45.116.115.51] (port=33594 helo=giis.co.in)
        by p3plcpnl0639.prod.phx3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <lakshmipathi.g@giis.co.in>)
        id 1iK4fr-006aUk-O6; Mon, 14 Oct 2019 11:02:28 -0700
Date:   Mon, 14 Oct 2019 23:32:16 +0530
From:   "Lakshmipathi.G" <lakshmipathi.g@giis.co.in>
To:     dsterba@suse.cz,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        thecybershadow@gmail.com, wqu@suse.com
Subject: Re: [PATCH] Setup GitLab-CI for btrfs-progs
Message-ID: <20191014180215.GA13772@giis.co.in>
References: <20190930165622.GA25114@giis.co.in>
 <20191007175235.GL2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007175235.GL2751@twin.jikos.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - p3plcpnl0639.prod.phx3.secureserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - giis.co.in
X-Get-Message-Sender-Via: p3plcpnl0639.prod.phx3.secureserver.net: authenticated_id: lakshmipathi.g@giis.co.in
X-Authenticated-Sender: p3plcpnl0639.prod.phx3.secureserver.net: lakshmipathi.g@giis.co.in
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4wfHnOvUmuU5Z2nwgqJ4ViqG+ZGu0LG8OgRRJPnDr6V4o8VOmNUy36hJIouTssdMNeU2vBmcTGCZbCk7pF1OUCbfZcZzMIK2cBEkI4QJh43AcFC+wE9SmE
 Xbi2eh1ecjOm3eEZev3r33iiaRHy7cmwuzn3NTZZR6O8Koej4zZqOFvgknv6G8D8GuG6ktMsIMlxRsQvqe8TCNvWH4apEp99YHsWvcslrWs9p9WWBNLmpPbM
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 07:52:35PM +0200, David Sterba wrote:
> 
> Is it possible to move the files to ci/gitlab? .gitlab-ci.yml must be
> probably in the top-level dir but that's acceptable.
> 
Ok added these changes to Patch V2.

> 
> The scripts look good to me but I have limited knowledge of the CI
> environment so I don't have objections against merging the patch. I'll
> spend some time experimenting but overall this seems in a good shape and
> we'll get further coverage (due to the new kernel) than what travis
> provides. Thanks.

Yes, please experiment with it. There are some failures in tests
https://gitlab.com/giis/btrfs-progs/pipelines/88716001 and I'm not sure 
whether its due to environment or missing packages or something else. 
Let me know, if something needs to be updated or fixed. thanks!

Cheers.
Lakshmipathi.G
