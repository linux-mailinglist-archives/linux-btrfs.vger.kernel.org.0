Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293F3179AA1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 22:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbgCDVE7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 16:04:59 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.108]:33711 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387398AbgCDVE7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 16:04:59 -0500
X-Greylist: delayed 1495 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2020 16:04:58 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id C7A3258DD3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2020 14:17:57 -0600 (CST)
Received: from box2278.bluehost.com ([50.87.176.218])
        by cmsmtp with SMTP
        id 9aSrjZzP1RP4z9aSrjxRXI; Wed, 04 Mar 2020 14:17:57 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=casa-di-locascio.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:To:From:References:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f222YWdHWpMhp0IffPwK3A1p3mcOIlnw509KAMX+o60=; b=W+1MQ5iMqkPpBRFe8+Q6ijP6aN
        40ylDqAZe8KifQnwVHNw56CgmOzdDqR14xchcJL6q1hGlfwbbKtU48Iqzivz6vblg53q8A6pLzxk+
        MfbKviUNSaawibgaFKvLIHjpV;
Received: from host86-179-160-76.range86-179.btcentralplus.com ([86.179.160.76]:18162 helo=[192.168.1.148])
        by box2278.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <roosoft@casa-di-locascio.net>)
        id 1j9aSr-0037wO-5h
        for linux-btrfs@vger.kernel.org; Wed, 04 Mar 2020 13:17:57 -0700
Subject: Re: USB reset + raid6 = majority of files unreadable
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com>
 <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com>
 <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAAW2-Zd4jGOBK6jxpqbOfwACTYkDg6Ep-EZ9Ejy7RuJEQn9F7Q@mail.gmail.com>
From:   "RooSoft Ltd @ bluehost" <roosoft@casa-di-locascio.net>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Autocrypt: addr=roosoft@casa-di-locascio.net; prefer-encrypt=mutual; keydata=
 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
Message-ID: <15ec9ccc-6bad-dc04-5008-7168ced1f7e4@casa-di-locascio.net>
Date:   Wed, 4 Mar 2020 20:17:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAW2-Zd4jGOBK6jxpqbOfwACTYkDg6Ep-EZ9Ejy7RuJEQn9F7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box2278.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - casa-di-locascio.net
X-BWhitelist: no
X-Source-IP: 86.179.160.76
X-Source-L: No
X-Exim-ID: 1j9aSr-0037wO-5h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host86-179-160-76.range86-179.btcentralplus.com ([192.168.1.148]) [86.179.160.76]:18162
X-Source-Auth: fpd_eacct+casa-di-locascio.net
X-Email-Count: 1
X-Source-Cap: Y2FzYWRpbG87Y2FzYWRpbG87Ym94MjI3OC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/03/2020 15:42, Jonathan H wrote:
> Update:
>
> My most recent scrub just finished. It found a few hundred errors, but
> many files that were not mentioned by the scrub at all are still
> unreadable. I started another scrub and it is finding new errors and
> correcting them, but I aborted it since I do feel like constantly
> scrubbing is making progress.
>
> Much more interestingly, I ran `btrfs rescue chunk-recover` and it
> reported that the majority (2847/3514) of my chunks were
> unrecoverable. The output from the `chunk-recover` is too long to
> include in a pastebin. Is there anything in particular that might be
> of interest?
>
> Also, I take the existence of unrecoverable chunks to mean that the
> filesystem is not salvageable, is that true?

I would suspect memory corruption at this stage then. Run memtest and if
it finds anything wrong switch to ECC and don't use that memory for
critical anything.

-- 
==

Don Alexander

