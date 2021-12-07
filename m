Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED2346BD00
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 14:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhLGN5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 08:57:34 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:36951 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231280AbhLGN5e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 08:57:34 -0500
X-Greylist: delayed 873 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2021 08:57:33 EST
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4J7hbt5Zq8z1y8M
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 14:54:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
        t=1638885242; bh=uyyM/UHcY6KTYnG5/umPpuo/5sH+DXTct8XlrVz4QK4=;
        h=Date:To:From:Subject:From:To:CC:Subject;
        b=td7yI02WZWQ7dUaI6vVZ3gXbUw9nPL2rNfhvsrYC5JI9DHaJDV+kJliL/b588bvof
         96ukmyriu8CeX7ocFSiWQKZU49Ago6igmZxarObvEaba0Sjp+5pEdVpm3uzVN2d4xy
         ASN/QwL9bLFYpi0XeNFZhOuxwjht+yDkOtzqEdM0DotA+js+o0EQpp0rKmWPq2RS4G
         rXVVkn4J/eBgQDBG3IMZ33Jy11d7jy9PFAiqU0CQXMl9R/Pqh8egWNPH9fvgnC2QOZ
         wfRWXouKP09apAUrLooe1TQdurKebmfEDT5r9MecYBadVZPdrxGnrU21ztrES9asY1
         M/3565UiWZcYA==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 87.180.117.41
Received: from hogwarts (p57b47529.dip0.t-ipconnect.de [87.180.117.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18nkm5DhTOVavg5NMrnEDToKC0ElLrTyIY=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4J7hbr2rDKz1y6V
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 14:54:00 +0100 (CET)
Message-ID: <c2ecfb9c-5044-a370-2362-8f67b44ce53c@hogwarts.middle.earth>
Date:   Tue, 7 Dec 2021 14:53:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   Maximilian Eichhorn <maximilian.eichhorn@fau.de>
Subject: Question for information about the Extend Tree structure
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Sir or Madam,

as part of a research project, I am working on the file system Btrfs and 
its structures.
More specifically, I am learning about the extend tree and marking 
individual areas as allocated.

In the course of this I also became aware of the wiki [1] and examined 
the information to be found there. However, not all aspects of the 
Extend Tree are clear to me yet. Therefore I turn to you with the 
question and request for further information.

In other file systems it is very easy to identify a certain block/sector 
as allocated or to manually mark it as allocated because of the existing
structures. Unfortunately, I have not been able to do this with Btrfs so 
far.

Thanks in advance for your help and efforts!

Kind regards,
Maximilian Eichhorn

