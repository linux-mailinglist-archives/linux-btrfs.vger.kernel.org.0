Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC0B2319F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 09:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgG2HCS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 03:02:18 -0400
Received: from mail-am6eur05olkn2087.outbound.protection.outlook.com ([40.92.91.87]:26272
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbgG2HCS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 03:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvoxSJIIEWWnZDyJhTg4UaYETLNbD9cCU36mlEHXLbQehb3uOQp8/UYNxwtyX6NILbE5BolCtGSQQ9mjg27RGRllHDolvzlBjitJ2IebIWoGg/jkf1FyBEhaDjgauWL6Jmo2BzPwgvHGxavdjTpVKPr4TW8fOsg0OOP8pTF9tLYRRWd+QErY4nVnO8zZ2adqTMBYj38r36wbL3wDxXmnzGWbIzG0ukYQWfhLAHTN2I0rJPUuqvOGq8GMoy97a8r4SdKN4llHEx9mKeLjE7Pfe2u7Z5BDpRkm9k5RGkc7Y2+nXbpuZVUpkdlF7ENEJSD9JI14lN3vRRJU3o75k1AbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Oy20vRDYvFO42aBY4PZBUYXJMdynvLnQSKK3UYJJ5k=;
 b=jgNjdAPCUEhDkJq89Fh+5TctQkpgkw9+4gqBJnA2ElbIkiaUDKagDCBdrOVJGO4R2vjWOTIIU9tc3Hs1onxIx3qiYrDjCeCFkz/Gn9WyA9VlE7VxxN3IDqY5AqpJ14bXuXWD0gE1bFhwK1DLrYIA4py3s6u7gjRvHo0ZvVy1bEWqlR+/WBHhfgzuV5jqYpRQvUty6i+T6l/ORNxqxtOP9H68nQ2H7M3mzKzavxiOsMsULMGFfxozL6W7x4r3QRZHIPTp19m2/dgYRCjAtzIY/EefEZEtvqE2QGuS62WVmqo44GYpfdMKzA21MJOmjlBmQS5bJtzqfyy5U2kjCESXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM6EUR05FT050.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::47) by
 AM6EUR05HT027.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::306)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.10; Wed, 29 Jul
 2020 07:02:15 +0000
Received: from VI1PR02MB5869.eurprd02.prod.outlook.com
 (2a01:111:e400:fc11::4f) by AM6EUR05FT050.mail.protection.outlook.com
 (2a01:111:e400:fc11::427) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.10 via Frontend
 Transport; Wed, 29 Jul 2020 07:02:15 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:EC7B25C4CA1D4C2130FC141096CBCC7717F74004716DA0B56D0E99C2260321C3;UpperCasedChecksum:38446662BA8150ACFF9B095973B6167F33D9FE0E0CB08FB52AEB0E2ADF523A12;SizeAsReceived:8487;Count:45
Received: from VI1PR02MB5869.eurprd02.prod.outlook.com
 ([fe80::e105:13a:cd84:ed29]) by VI1PR02MB5869.eurprd02.prod.outlook.com
 ([fe80::e105:13a:cd84:ed29%7]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 07:02:15 +0000
Message-ID: <VI1PR02MB58697B26A91E68507032D9CDAE700@VI1PR02MB5869.eurprd02.prod.outlook.com>
Subject: using btrfs subvolume as a write once read many medium
From:   spaarder <spaarder@hotmail.nl>
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 29 Jul 2020 09:02:14 +0200
User-Agent: Evolution 3.36.3-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0162.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::31) To VI1PR02MB5869.eurprd02.prod.outlook.com
 (2603:10a6:803:12e::18)
X-Microsoft-Original-Message-ID: <d11d3058a9d933edbae2ed090b18c89d74fbd340.camel@hotmail.nl>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from laptop-hans.local (85.144.193.86) by AM0PR01CA0162.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Wed, 29 Jul 2020 07:02:15 +0000
X-Microsoft-Original-Message-ID: <d11d3058a9d933edbae2ed090b18c89d74fbd340.camel@hotmail.nl>
X-TMN:  [Tyw6olrp06I3ayT8BuWrvEANwA4hO9Tm]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 2779514f-9e94-47ec-0eaf-08d8338d5375
X-MS-TrafficTypeDiagnostic: AM6EUR05HT027:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZVMGlGv5wu6lJNIBIOkaKY7YHQ8PSmdp2EvWarSUVmEVGYCsvIFEjCy1vQPzwtlTND4uXpkJFJLBS8pUv2E3dNvnL+eIRPv/0/kzjPiVtgsmQ8/dEHZYNJkPovnofqwWqWpXF9siGOElK6RmC1Q1iw8r98F3GENoMsTA3ttudPmtEVrMTrJ0gV7SEZvHETpFPjpvlIT+W3wKqKAqw3iNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB5869.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: u4NxotBG0GuTOCK/X4fv1AmAdSBRNb177teTBX5BuT7QOPUHPcn57eWAWjewMjvmq5LcvmaTk+stsVpVV/wVsxFk2Jbdt7N4NcymSXJjnGnJwUSu9P8Xd28opXX6N3g7kxGAKdjiOZbfrDV6GPjG9Q==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2779514f-9e94-47ec-0eaf-08d8338d5375
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 07:02:15.8422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT050.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT027
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

With all the ransomware attacks I am looking for a "write once read
many" (WORM) solution, so that if an attacker manages to get root
access on my backup server, it would be impossible for him to
delete/encrypt my backups.

Using btrbk I already have readonly daily snapshots on my backupserver.
Is there any way to password protect the changing of the properties of
these subvolumes, so an attacker could not just simply set the RO
property to false? Any support for a feature request?

Big thanks for this MAGNIFICENT filesystem!!


