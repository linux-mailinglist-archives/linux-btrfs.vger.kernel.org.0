Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225D8CDAC5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 05:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfJGDe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Oct 2019 23:34:29 -0400
Received: from p3nlsmtpcp01-04.prod.phx3.secureserver.net ([184.168.200.145]:34928
        "EHLO p3nlsmtpcp01-04.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfJGDe3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 6 Oct 2019 23:34:29 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Oct 2019 23:34:29 EDT
Received: from p3plcpnl0639.prod.phx3.secureserver.net ([50.62.176.166])
        by : HOSTING RELAY : with ESMTP
        id HJeoiaxDf7wBxHJeoi3vOb; Sun, 06 Oct 2019 20:25:58 -0700
Received: from [45.116.115.51] (port=44124 helo=giis.co.in)
        by p3plcpnl0639.prod.phx3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <lakshmipathi.g@giis.co.in>)
        id 1iHJen-00Gmbp-Ep; Sun, 06 Oct 2019 20:25:58 -0700
Date:   Mon, 7 Oct 2019 08:55:47 +0530
From:   "Lakshmipathi.G" <lakshmipathi.g@giis.co.in>
To:     Philipp Hahn <pmhahn+btrfs@pmhahn.de>
Cc:     "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        thecybershadow@gmail.com, wqu@suse.com
Subject: Re: [PATCH] Setup GitLab-CI for btrfs-progs
Message-ID: <20191007032546.GB5135@giis.co.in>
References: <20190930165622.GA25114@giis.co.in>
 <1ecbc32d-9f28-b0f5-bf2d-8ceee12d6404@pmhahn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ecbc32d-9f28-b0f5-bf2d-8ceee12d6404@pmhahn.de>
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
X-CMAE-Envelope: MS4wfDqidP6qngvUW6bi9Q1maKPoSxbo3pVlEkhQxwpx/6njl45XxNjHKfDmLcvP5KAIa069jVf+sXDN0fZV6acyKT0aQRXAV1cLApHz+s8Ca8ECAbGr4alC
 E11FqFqqmgtqD11LT4gsyjWmmq44O0TTBaFONIEVqoxu79hBhqqUsOHcr+YCtFGzcmH/Jx+nP9AQ+5wetHL6DIZy4BxEg2WglooVELmLc+Cwn0iOv8UikqTP
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 01, 2019 at 08:02:29AM +0200, Philipp Hahn wrote:
> 
> You already have a "variables" section above - merge them?
> 
> > +  services:
> > +    - docker:18.09.7-dind
> 
> You already have "services" defined globally - no need to repeat that
> here again.
> 
Hi Philipp,

Thanks for the comments. I ran into some issue while using global section so
started using job section. Let me try placing them in global and update the 
results. thanks.

Cheers.
Lakshmipathi.G 
