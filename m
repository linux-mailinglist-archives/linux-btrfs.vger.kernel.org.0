Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C0B253B93
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 03:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgH0BtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 21:49:13 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:10145
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbgH0BtJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 21:49:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPA/CNWUo7Csw61HXoYmw8BBiMCq60/m2xPRWyHRahE4WITpnuxyq5bSGz8lWG3W5EYd9OOQLdwVNVVsWajdraONFKnxZmdGoKC5/k6VS/9DR55krsSqwsgYvCByHrL55+26Vf25WkbE8V2OjS3faOqHAtlkHDwsqisDH1MfGITfdH5RjddMAlIX3C+Dq21OXNGpGDtpetR0Zl5qjHQU+92jyTG6D1ngBFjjVkKaAVNx3c8I8IffqzQRbmfZvSBoya/fZlNrViy90ePIvWsYZzV/C2R3ol0JK2N5UDz02wsOsY6oC7J92n+xJUnS/lPP8pUXOSQ1sIb2DKoHzvB2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGyCNf5L0riLSfx5niMkIp64eWqtX4/RQ8Q1j+pX4FY=;
 b=X5d+sRjzrPG4KS091FQRL3yqfy2ID+fEwihVDlnkp1mbUdq+EoH92Rjo4pisVS2De5BQEysZFRBm5KAyqzkCjPSUZLvTRvZ67GusLDwPn/NdpuryM9/Egb02jCJdSFlj+NqGCNAywtN3iukl/Jm7Nh2zCaRCjsZWbuXJLZqdMkm4DwlbQXVFyxqXaoUJYrWCnEjnsth+uX49XdGPnDOb631HHnVyT1alDzRFh6pAX8yuMU15G8RddstVZ2eFDG8sCFO5WcmmMNNsjawjCfr7fqh+D7+O9pz0h0Yh0NHT+BGDFvDMkyFRvC442zgzKUhs5Lb4De175LI4o3eqnNUrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGyCNf5L0riLSfx5niMkIp64eWqtX4/RQ8Q1j+pX4FY=;
 b=CTFvlJoIHHT8RXKmFR9/jlVEpMkSUYlVubr8/txh4Lk4q/kpoAyQY0azaMAhLmcC2ZinMqWM57Ww4AZgxEOm9IN72GTkL6GU+nRYrT0MOC4wan5YQiq71AS9F5rLaAiUtGWHynFYg1YBeoCvTqLtSpt4QcNPQjJEaThQloVFMFw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BY5PR08MB6200.namprd08.prod.outlook.com (2603:10b6:a03:1e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 01:49:06 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::3819:8560:afcd:bc6c]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::3819:8560:afcd:bc6c%6]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 01:49:06 +0000
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Subject: Log corruption/failure to mount during powerfail+deletes
Message-ID: <33a0b9bc-8cd7-803a-2322-54014703d263@panasas.com>
Date:   Wed, 26 Aug 2020 21:49:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0019.namprd14.prod.outlook.com
 (2603:10b6:208:23e::24) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR14CA0019.namprd14.prod.outlook.com (2603:10b6:208:23e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 01:49:05 +0000
X-Originating-IP: [96.236.219.216]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f64cb16-3b41-4b1e-e7ee-08d84a2b61f8
X-MS-TrafficTypeDiagnostic: BY5PR08MB6200:
X-Microsoft-Antispam-PRVS: <BY5PR08MB6200A3029AE8D2C42AFDB852C2550@BY5PR08MB6200.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUtLk9ZviQVvm6NougKcG3Q/u/PZOIaWoHj7M/nYCd926yR2isc2S4L+kcVtWIPiRnuUamv9xCcqH3TotsiKKZds70brsEi8kqCjfwVYAigcnsi/9Qm/YsuWkmi8J9PnJH9YE5ymM+tPekQztO26sdKvOgEIJRwD90jsIyBI2+PPOt57hlX/gZ4s4+09x8z5xvoarPX7O4WihexpzIF9bFN7PxpN69hdbbSYgl+oX+uVFniur8R81iRBY1bvxzdLqvTHaUZErz5cA4h9GPKYFcOw5rs5BgOnO4rAVR3bNEH52zUMFuHMexDxZMi1SstxazXS2mV6/kvOIyjnltLu/ORXLUnVWprErk8DReqMScNYT3yfjGDJOjclSCwVN0F2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(346002)(366004)(396003)(376002)(316002)(2906002)(956004)(16576012)(478600001)(8676002)(83380400001)(6916009)(86362001)(31696002)(31686004)(66946007)(8936002)(52116002)(2616005)(186003)(66556008)(5660300002)(36756003)(26005)(6486002)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qXI2JQTbUAbmrxOYJ7mzxOB5RMrbH/NTiE9BtVMFlcVr+K7YoCin6cqsLkUO/CKSxdwH0nHc07INPkeF5Qz9xXGSVs71/o8nAqhrVP6hUEM0gkRCso11S0/DeWD0Z2Su5AxoeuTfp8Us6sY77MtDePm0jvnY4LWwOfXCE33ebrbFXyNHHlOUeUZalfs0kPG++bTE4gnA5hEXak/vfVPxqLAWOZfbOWIt2AN+Sy7tyLFZw5v46sMowpaHE7qCMkktpwVwm4U6aUNHxWDXsq6H4pP4pTgl7CtwSF7EeP5pYnFf8I8POnB09CBEgcapbrpVtuCD3X8vu/4sUqzMvDBX0GYIoPvRd9OGZrZTHscgpY+5491GT72r47A6/cC1u+1QAYKvCXm5nG/tm1HMDB2ZbX5ZIhrycXqcPg0Ykc6yonvzIRrViLAisagPVn0OWMCKBU7s1qybnDUqgGPD1yheW3euUOFEtL+dS2Wsacg0U2tf8gY2Hc0dawVPh0hEsceAUdbG4cwpHqHTarY4Iir1Z/bgSVJIH+k4VYc7Uf4DpijscdBV0zJM8R5NrofL9pfiG/wwgT9wwY+hHu10MVCm9bWpA5Q7WprDZd/HIlWml/G67u41MSrjljqMcq+qQ5OddGcKaS4C4FkVae+AdQMWJw==
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f64cb16-3b41-4b1e-e7ee-08d84a2b61f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB5109.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 01:49:06.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BZHcOgOsZ4EBquczaHFRW2RpAo3WcFHHw566dl6R74TYdHB/LSPaFP30inj//APRd/CQCjUaDNxSYPlwysF4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR08MB6200
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

We're experiencing some issues with power-fail testing of BTRFS as 
provided via openSuSE 15.1.  In short, under heavy delete workloads and 
injected warm-resets (via ipmitool power reset from remote hosts) we run 
into a subsequently unmountable filesystem.

Logs messages in journald are consistent and show up like this:

Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS info (device sdg2): using 
free space tree
Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS info (device sdg2): has 
skinny extents
Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS info (device sdg2): 
detected SSD devices, enabling SSD mode
Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS error (device sdg2): parent 
transid verify failed on 15216132096 wanted 273 found 271
Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS warning (device sdg2): 
failed to read log tree
Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS error (device sdg2): 
open_ctree failed

The SuSE-patched kernel for 15.1 is: 4.12.14-lp151.28.59-default

The only non-standard option we're using is space_cache=v2.  We cannot 
reproduce this behavior on openSuSe 15.0 (4.12.14-lp150.11-default) 
under the same conditions and testing.  btrfs rescue zero-logs does get 
the filesystem mountable again, but tosses a non-trivial amount of 
recently-written data in the process.

I am hopeful this is a known issue and has been fixed in a patch not 
absorbed via the patches applied to 4.12.14 by openSuSE devs, but it's 
been hard trawling through changelists to determine that myself.

If anybody recognizes this issue or has suggestions on if or when such a 
fix would have come in, I'm all ears.

Thanks,

ellis
