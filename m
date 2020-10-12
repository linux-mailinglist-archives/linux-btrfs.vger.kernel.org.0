Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C7D28BF37
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 19:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390262AbgJLRvW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 13:51:22 -0400
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com ([40.107.94.74]:55745
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389562AbgJLRvW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 13:51:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8taTJAIwfk7Uj7Re5+lLuTY475bKLK1Gjv+3PdwbSMyFIBW+JBDA679lekG0cga7XT9B5jGIsGJl3E3J03uXWnb9k6rKnBIxKb9M/Xl/N957uH4O3kaLLDwHtuHSRL44O4oburRnEPRtAeufrvHfQFHWbTeKWAL5ncHFCLgXzvsEaIDgi0Es90bBzWgh5lFVYd33wUc42/u8L0PZwoyoVb3n3KM2KYNPkCBZKqG7RcY6iY3OxM2kN972nVVN/EkGC4EgDTpdC8f4CfQ0kOnpVaVNZncd4Svpz1QHdJnLE7YCXbB3ouQVkmg8xQb6A6WVIpqjGLCFoJ+b7n7OgH9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmSzBBcH8y0/WSpjx/dKKuaKDpG3lg3X7s/4mDClKo4=;
 b=LvO+lr+c5DGKcN2WNlY8jQSAij70VZ/Is1dYLm4V4Vs4nLfV/Ja52MB0qhP9zEFonhOdLyxcbXnstREk1qEO0He/p5w/sz1+rNCOTkE6oqztzZMpaQnp0IqX9MCfMeJjQ4JJqb4UXgfCFHxxHjenvkOtAuT+IRlZ81ZzltiZisQBub+O0pdGUNOuX05Sd+Bl7QvQkwDkWzWn8XRPKVCl75KjaRjMJU9KFUo3aINA4o/7PUiRs/nB40ts/noe9Qxepl2zLLZAcqE3vwed3111F6/ZIW9zHaAvVokx8jTEj6VGDHDw+r37bDazEENNxYstrOceh3ujlxbCWNxZ2CzImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmSzBBcH8y0/WSpjx/dKKuaKDpG3lg3X7s/4mDClKo4=;
 b=T7NBFJYZsRcAiae+lP2Mm2I0QzN8t1g/vf1M7aJ7nYa6MJFxX4Ve1nh90f+yF9yZ3J9aJCoXOVgnawXD11O0bW0XOy7BeAhPU0b/hFUMVjEmCzunmwdsaKLzF9Q2PBh0niWjwvaLpFvh11AVQZ0Bic7nSoRHqG1Aipn2GrYqgMI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BYAPR08MB5111.namprd08.prod.outlook.com (2603:10b6:a03:63::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 17:51:19 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::3819:8560:afcd:bc6c]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::3819:8560:afcd:bc6c%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 17:51:18 +0000
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Subject: Tracking Previously (or to-be-) TRIM'd Blocks
Message-ID: <a75c093a-ce4f-d4cc-8659-22072d7468b2@panasas.com>
Date:   Mon, 12 Oct 2020 13:51:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [96.236.219.216]
X-ClientProxiedBy: MN2PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:23a::9) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.2] (96.236.219.216) by MN2PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:23a::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Mon, 12 Oct 2020 17:51:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79df29de-22d6-4157-2db0-08d86ed76c45
X-MS-TrafficTypeDiagnostic: BYAPR08MB5111:
X-Microsoft-Antispam-PRVS: <BYAPR08MB5111303FDFEFF35F09467B1CC2070@BYAPR08MB5111.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WoFo/i3UvwFm8VMpS+QykTS773jSaoTGeEQxw8Lg+3R1MUrCW9t8ZVp4ADfB4l1PpSZkYikk2fVxlehXlcVJAqoi9Z1bCFf5Ih+8b6TrwkxosUaAsbJoKEIVZLpWWzLjaJ2sLUgK6PVoom9j1o006dWCp9cB4Zq7G6QKuoogz418aQhotlVm+kzPChX54gCBcBPdyUwGeLnoMh67PKwsi+OUNSlptkfOi+L4BNacM3lV3O/tXK8FOVt2v17dQ2FSy/qLIPn4N5R3uTPygtsWPRp7K5Ht+z2x4koRkAD7U8cMkyW68zMdIFT1fNrIGkmnXvSLHguTHO0vnnv9ssvC/zjRsMoSL6UhrimOgJ/5PFv2ySzsvdMkr4hEF0T+vqbZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39840400004)(396003)(136003)(52116002)(6486002)(478600001)(5660300002)(36756003)(186003)(66476007)(8936002)(6916009)(83380400001)(66556008)(8676002)(86362001)(2616005)(956004)(316002)(31696002)(16576012)(31686004)(66946007)(26005)(2906002)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: h/CaAyhebCYFs+nOAbYjDk8pRkPFtUSei27ALnLp/VeA6IwJh7P1UoDOrJmNPu2+wLWLkYBxpEd/R0SNr6cQdRDtMPKjdqEflA1kuQnZYXMozmyhrLX2IuXjbg96kvSjSrtKIwdS0+4CLnXjgE0IZP8ORE17TrrB9CCFZEjxIE1huhdGAcj00iuSG5Ja96VsGC8UXUXcKGHuFY0jfTEAp4mbRdNbYerXvkyOVKrrZ6VlwTMPOywk/hPG/WgQcdrOwtATmetBZ/j9XYZ5BlVCIleleRcgKS5KHCAA2wp3YKzo8v0SaegXSl/7k2vbTZfgpWWxDoLjd7IZyDV8FMRWWxLLROCYXXwbS0+DMI9THkg3Q63n04a0eib2/6V91sz/KJREngz4a/xluTfVx/DO7Cui2LbD+uI8L9/pLP1RFWgtsbaqX7VDoqbO0iwMx+N+22fREdA1Mwk0E/SKPidDr0TkUdSLe9wJLuDyAN6z/08iY0STGhtIJZc5hHAt30AoLvL4V+iac7SSrSLz19A2Bzqiiznjfccu8TXcfY+rPyVrJAm+k7ly+MWnnJJaXnznoCPPzuZ94sdNk3gOsZ6169h92/p1NPKro9VanMAIyDnyCOJnwm1wyx6VF9aoUV0MyCASU+ZsSaaPVAHLj+Z3fQ==
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79df29de-22d6-4157-2db0-08d86ed76c45
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB5109.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 17:51:18.8501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owpOW4/zhQlhGvFFZfHfO0BpHLx/G99cGOAXgvfLYpCAVIQE9QFQT/cPVAE2GPdHtCfKOUWCI3TYkfGy1MgLpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5111
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

Another performance-related question.  We use fstrim to TRIM our 
SATA-SSD backed BTRFS filesystems at daily and weekly intervals, 
typically with a 1MB minimum size specified.  Without such thresholds 
the time to complete can be extremely onerous (approaching 10 hours).

I note that (via dstat) after a short blip where low reads/writes are 
being done the throughput ramps to 86GB/s.  While fast, even in the case 
of an empty SATA SSD that's been previously trimmed and nothing 
additional written to it, it will take 47 seconds to trim and will be 
largely unresponsive during that time even if the underlying SSD does 
little to no actual erases.

Are there any plans to track previously trimmed (or to-be-trimmed) 
blocks as ext4 does, or does such functionality exist in a more modern 
release (we're running on roughly 5.5)?  Apologies if this is an 
old/previously discussed topic.  My search-engine-foo is failing me.

Alternatively, is there any way to instruct BTRFS to take it's time 
issuing the TRIM commands to the underlying SSD, or break large 
contiguous ranges into smaller ones to improve QoS for other commands? 
Right now it appears BTRFS goes as fast as possible and can leave 
userspace processes stuck in D state for extreme amounts of time for 
more aggressive TRIM runs.

Thanks,

ellis
