Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB43CB971
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 13:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfJDLqi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 07:46:38 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43935 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfJDLqi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 07:46:38 -0400
X-Originating-IP: 163.158.29.153
Received: from katrien.duckstad.net (153-029-158-163.dynamic.caiway.nl [163.158.29.153])
        (Authenticated sender: relay@duckstad.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 149D02001E;
        Fri,  4 Oct 2019 11:46:35 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id 2C1FA38037;
        Fri,  4 Oct 2019 13:46:35 +0200 (CEST)
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dUSztWkXQexw; Fri,  4 Oct 2019 13:46:33 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id 4C7B038038;
        Fri,  4 Oct 2019 13:46:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 katrien.duckstad.net 4C7B038038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duckstad.net;
        s=EEE0E95C-ABE4-11E9-AA35-1FC771689572; t=1570189593;
        bh=J3KxlZlpyjZzUcXC/s4SPVByjBR5natvhcUfDWwPwZw=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=qVYJEdUCRD3llcPggHy2lNcWewLn1lBSavFvEXX8MNA8GU/fApsArHMcDutOSDNKp
         Zz4bzHwUjC2clSp9Da3wiuY3YcTKDo/DUEAf87Z2tbAzc1sHk5RokjLLWucEKXJ2Hr
         tUddGC9kornblkdbPpmorX763wSp0OIQO3fGM9gE1FQ1ku6XKiEn6OXauvWklfkpaJ
         QFmAssswL3dN9nbgZgFPGwUY8wq0f/2MqWbB9Of+JHOFF+xmNxvr90xQPGVVRMewVb
         Qu3xSc2xtpaRcQX1K0plyVcuKdCA2YjR5w5sxSJcz2+YcHn6JKbX3/q9UviS0IyI4Q
         VIXlUTOycbjwg==
X-Virus-Scanned: amavisd-new at katrien.duckstad.net
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KTgaAZzPeJqS; Fri,  4 Oct 2019 13:46:33 +0200 (CEST)
Received: from bolderbast (unknown [10.4.2.1])
        by katrien.duckstad.net (Postfix) with ESMTPSA id 240D138037;
        Fri,  4 Oct 2019 13:46:31 +0200 (CEST)
Message-ID: <4d29b52c557995897f60effca6e7899d0abacfb8.camel@duckstad.net>
Subject: Re: BTRFS errors, and won't mount
From:   Patrick Dijkgraaf <bolderbast@duckstad.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Fri, 04 Oct 2019 13:46:31 +0200
In-Reply-To: <2923c00a7460329a673b9b0669480cb568b2848f.camel@duckstad.net>
References: <2649522a0283fc35ade2218755063f8ff0dc4aa4.camel@duckstad.net>
         <293de2b3-506a-0fcc-f692-0fc03012941c@gmx.com>
         <1a5483ba85372d02d898ae9650686e591f82a735.camel@duckstad.net>
         <2923c00a7460329a673b9b0669480cb568b2848f.camel@duckstad.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Tried it with backup roots and it won't mount. I have a backup of a
week ago and I'll accept the dataloss.

I'll rebuild (this time without BTRFS RAID5/6) and restore.

Thanks for your help!

-- 
Groet / Cheers,
Patrick Dijkgraaf



On Fri, 2019-10-04 at 09:59 +0200, Patrick Dijkgraaf wrote:
> Decided to upgrade my system to the latest and give it a shot:
> 
> # btrfs check /dev/sde2
> Opening filesystem to check...
> parent transid verify failed on 4314780106752 wanted 470169 found
> 470107
> checksum verify failed on 4314780106752 found 7077566E wanted
> 9494EBD8
> checksum verify failed on 4314780106752 found 489FC179 wanted
> 73D057EA
> checksum verify failed on 4314780106752 found 489FC179 wanted
> 73D057EA
> bad tree block 4314780106752, bytenr mismatch, want=4314780106752,
> have=20212047631104
> ERROR: cannot open file system
> 
> # uname -r
> 5.3.1-arch1-1-ARCH
> 
> # btrfs --version
> btrfs-progs v5.2.2
> 
> Does that help anything?
> 
> 

