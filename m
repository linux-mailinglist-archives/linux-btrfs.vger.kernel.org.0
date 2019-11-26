Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF0109DE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 13:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfKZMZh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 07:25:37 -0500
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21417 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfKZMZh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 07:25:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574771134; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=lnpFONzipWC54XFq/iJFxVN50amrpIYQXFWd6ylW2gw4SRPGWiUkGtAytga9yp38Du6WoW8eTWe/sVLMgqmAuIJgiOaQ/WwymQGfmZnXSE85yrqt4jJb/onMZSKpjGr/dbDFdxmWo4uT8T/vZ4IMHSpzyWrv2E3aMdOe4apUggw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574771134; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:To; 
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=; 
        b=cLR05CNSu7xsKMhseN8FxLUW2xX1olYOpqr0spuk/HICUJSArsm47ZmikIWN8fso7dGfsaUPOJXSSFZzQyc7bLuzaGjDr6VWRk/JYxfArX/tkCfJQN7qwIXOR6BotGBUMWEV+QW3i5lpgnXYiRAakbZGak1ezRkwXJ1TyCgsW6Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=gcfam.net;
        spf=pass  smtp.mailfrom=marcfgrondin@gcfam.net;
        dmarc=pass header.from=<marcfgrondin@gcfam.net> header.from=<marcfgrondin@gcfam.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574771134;
        s=mail; d=gcfam.net; i=marcfgrondin@gcfam.net;
        h=To:From:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=QcJXDPmKqexu56INdqWOreIVXkWSKoq8gBcPpMkvNQPRZSTDmHgEnq+BxmJvnDtp
        3zCwz3jxvctoIlTbvG2LZ8QEvIqg2wIDbzceXPuPCNPOn/bSnnyfbKbpl8qB3Z3wJN6
        zFGwVvb3pOV4veE0RvGtbT9hHYLjCsdJKPxfM+5M=
Received: from [192.168.2.2] (mctnnbsa45w-156-34-211-51.dhcp-dynamic.fibreop.nb.bellaliant.net [156.34.211.51]) by mx.zohomail.com
        with SMTPS id 1574771132602557.8403722593891; Tue, 26 Nov 2019 04:25:32 -0800 (PST)
To:     linux-btrfs@vger.kernel.org
From:   Marc Grondin <marcfgrondin@gcfam.net>
Message-ID: <0c469217-afd5-16cd-e171-d1af77387974@gcfam.net>
Date:   Tue, 26 Nov 2019 08:25:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ZohoMailClient: External
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

unsubscribe


