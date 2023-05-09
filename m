Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF90F6FBBCD
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjEIADj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEIADh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:03:37 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278277D95
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683590617; x=1715126617;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=HFw0qR/+5VSpcyECNNIUI8A2LauQREhvPBkxYwL7aBex/U44o5TP+GYg
   2Li/RK7t4P77ol3cyHFGeBxV3Ntv3PdtZosIVbjPnYejxr2hkhW9Ed3l/
   3VIjYu9QgdZrdEGl82WtQ/iE2cgC3FIvipNNdGfRWu7PCWVpPRj+B7ZBP
   4zi1errw7KypJFrNpQHhcGb2qq0V7P+onF8f1rhsINb+Y1wthuxrE80h8
   7EUm8udpU/3jIfT+fzQApq2gx2UxMiTG7Pbm2Trs3yuD/6ergyfrflRcS
   9SNcqSniR6OG/vReApxC89vZgvjEf4r3I2JPdUKVL9/ojou4gkx1fZzmJ
   A==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="342232940"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 08:03:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4wWBEHFnnqc8+XnINHd+i/nMsc5VTOCRuhZq1AXMEsl4eGb80pp5AZFUZwxVZ1SM3toyFaz41uI0iWrYjxciILL0WxX0q1LozWi7UrWyDH1yk5rqGYCw/oLQJOmu0IWl9emlx9zJmvD3cScKydC9XoEJVody2K+5HgflgIUZjRcA1ge7+WlhExEjwoNA9PsoApEemrgtlYYyo4cHp1/KFyAvpeAMiqFLdM5+8DbhpzWMp29igv02Yvz18fa13snkRKnJNNAUnXCCAwO9cwjEWR1/WgvUpflvr53cfQDI4QB15OjN3oRKjBbsNH40XxfvicHvoQb1UWTe/REZhD+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=EQJB12e5CdfEag/DCBHv5SufxwXBBcMnsHGm7a+nNyZmJH8VtiokLtd5So2kAWHajKdzUXdY7XP1ZZJGBCWneRpwcqJafSQS6RvMeRcH625pkyHsNmJYEnpxOpwIaRWIaAhcCROcfmQ7Lzw6hyZ54nxkIlz8elvOhV81YrPyPZZDIhBVcDAF279nD2Sgb5pl+ykN23K5z/go5X7xS2rCTMKzxUaTz3tn6T8UDkPiytoJZHLoREjPk6N3EcaLUOkcWNVJjwoi+kPGMDWH5OUdZ83+47a/CKzkZ4PPLgC1vGcmGFFfO26KB8Mq+Ib4WD0E/iwBc3rsupJV1Q9yefJARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Tl5jcsjvAUyZBoK07rRMDUV5Rulfaf+3Asaa0LMHEHO9KyF05bukxKd2jL7OlaX0vEIa3A0E9SVqnwFQqqlRDCzWE0dJXVrdkyxauTfTEJg+iiYEsk0zE0JFS9lffeBI0ycQahlBzQ326/fTS7+UXaPWCw+R2kWKwRYYOB4sGPs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW6PR04MB8871.namprd04.prod.outlook.com (2603:10b6:303:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 00:03:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:03:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 11/21] btrfs: open code btrfs_bio_end_io in
 btrfs_dio_submit_io
Thread-Topic: [PATCH 11/21] btrfs: open code btrfs_bio_end_io in
 btrfs_dio_submit_io
Thread-Index: AQHZgcdxMIZHrPV770CsWzCJWAMtwa9RD9SA
Date:   Tue, 9 May 2023 00:03:33 +0000
Message-ID: <a1a8ecbd-1262-b953-3513-90a38088b42a@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-12-hch@lst.de>
In-Reply-To: <20230508160843.133013-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW6PR04MB8871:EE_
x-ms-office365-filtering-correlation-id: 1eccbd3b-745a-4c23-3030-08db5020d486
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUd7TGwj36rDiD4wCd8N2aDi9Sc72recVC8dArcqwJ3lhHbX5igLtTB9AmATY+8eJPz8gbEr+Qcktuuc/V6Nartf9S7nQNP/DKexvD6rRkiXAPOrp3CDFgUw8pdTmwcYZq3coNzG08Psdjq4amL9pifYtIhYYKIgNA8/DVAQxiHH/+m5nyFqC+FjAewC6EnC8Cho8l5dJygqeS+8ZUh9ZAiBTRfDOMX9EBlOnhLxUhx9d1FFQQseysW4YJqPr9WC5dD6ODl7V8CFmoYoX52ENB0mnzLRjh9qTyTa8xGmiaxus3FY5mAo+Q2qUd5dVa+WlNpCzbVxrHTJ4mbhkhx4mTnjXSbSmczeVZd6yhDJg8/hlj8oCdE2xkxEsyKaBwKFFYV2stnxXqKcOB+bakYtEGvh1I7CBRCh6+CsuN9mJGYYP9og3+bFIpKWdOHOgukhY29TrAOMB5l2VaJnxHDIrqlspAi6WDLWHTgFKPLmloSgab2m+Jlt+DWjntBnjY5d2lb/jt1Fn5UMVlaW3gfY98Hc2segXxeoBU3cjA8nz6KGojWGDWXdyzNMxfzlHuB4lqfrYtCXqcYRTrxeECuJ/B5u6qObToxUrvdjft07ibbzeUI8/6jynzmJGoSJKe8pZz1wfYH/Z+MeaCTW7LMuhS8bnkxQ64K5rTP1ciATnWFD38oljJB3FrVeWzcWxN/X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(31686004)(4326008)(2906002)(8936002)(478600001)(316002)(64756008)(66476007)(5660300002)(66446008)(66556008)(8676002)(41300700001)(4270600006)(110136005)(71200400001)(76116006)(19618925003)(66946007)(6486002)(6512007)(26005)(6506007)(186003)(82960400001)(2616005)(36756003)(38070700005)(558084003)(38100700002)(31696002)(86362001)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW9zdEMxK2U3UEw4akdscFZpZ1l1OXJid2J1ZE4reVRVUHhvUld5cjZYb2lx?=
 =?utf-8?B?ZHh1OEhUT1pZS0V0elJnQnRTL0tIaCtwaGJtVEJwNTlKRjVqcndEdkVYMVAw?=
 =?utf-8?B?MHVJTXNpaFNhY3ZIRDFobGJ4ZFN5SW4wSHNiN0lXV3I4dzBSY3gwZG1zdkxy?=
 =?utf-8?B?WTd1YVhjNm9KTmlGUHJ4SUhaT3A4eFJsSkZBZk91QXVOOXFsdDhCbDFBdUcy?=
 =?utf-8?B?VWdlNlJvOU9jZUpVNGhuVy9KRnBpK2xSdjFNVWVXaDE4OEFuTVlQWjBsS2FV?=
 =?utf-8?B?cWxISzJ5Q3lKSFB6aitEdS9RNm5aVk1lUWFhd052anZoaHRwTkEwZndGV3JG?=
 =?utf-8?B?ZU5UQ0paT0hLeE81Q0N5dUdxYjJqUGFGeXEyWlA0bUhsVzJ6cmEwTHMrZW0r?=
 =?utf-8?B?SFp6akpwT2JDaGlTNXo1WkhRN2VVdEpSWXdxdmtBWHl5MVdBVFc3Vi8yM0pY?=
 =?utf-8?B?ejRJbHVJTDRndlFRNytjaGljeDVqVDlicGgrVE94RytPTE5oTnFUdi9UNFJY?=
 =?utf-8?B?QnRlU210WEF4a2xra05QMHBXYllNY2JNbkxJbmRUcWkzL0RGNjcxcU40aldW?=
 =?utf-8?B?Tmwzc25xbGgxbEpaY2U2TkRWT0dZTXN2dVYvaUEzT1ZHOGo3NmJvSkRTMk1R?=
 =?utf-8?B?RDFPdVA3ZXpnS1h1ZmdTYTczR3U1cVREMFdQRTVobm16L1RuU1ZmdUNYZzJY?=
 =?utf-8?B?Yy82dVQyZlhLZ1RZVElPQnpyWElBM2lOcmxxY2pocWlVLzRXYnpEY3pFQ0dn?=
 =?utf-8?B?dkJaWldXdThUVXJjV1BWVWN0WHJ6WGhRSFJHVk15MFpVcURZc2JPNEIyOGw5?=
 =?utf-8?B?TCszRW0zS2s1Wmt3QitrTThzN0I0cG5WQzUyT2pEMUtndE84RlNQOGRGaHQx?=
 =?utf-8?B?cUdSQjMyNEY1K2JuTk5TMEZWNjVHZVZLLzlhaVFmSno3T09XZ3l5SldBcXBF?=
 =?utf-8?B?SG9LdzFsNVJJejRBWStFZndoOUlvb3VzZTZrbldMdE9oQTJpZ3psMW1iZ1NH?=
 =?utf-8?B?Uy9veDJPb2NIaGp3VUdNV0lDa3pUWGtndlJhbkw1MDdzSTR2NjhnVHE1OGM4?=
 =?utf-8?B?eDFKazU0U3IzVmcrRHNRS0R2QWdkNXF6aHl6WW1uQVpSZTJFQVl2MFNZWkhD?=
 =?utf-8?B?RmlPY3F5SGE1OTdmYXgwb0RkM1BTTVhwM2MzczYvNUZ5bFlnL3ZYS3NaMUJK?=
 =?utf-8?B?NlZmUXROQXlUaUZPV0cyeTNuM0JmazlmQ2RLcG9XNmdyUnNiMGlJS0FybXZO?=
 =?utf-8?B?eEhJNWdxNEtRQXNySVZwaXNvTm9FOXd4WlY4VmNWYkRWeFRzakhOSy9DaVV2?=
 =?utf-8?B?bzFyUkgxMlNqNzJOTnZTdWRJeWsvUE5NSlBpZzhsZDBkdGdSU2p3cGtxMjh6?=
 =?utf-8?B?OHQvVEhubU5YeUZQU240VnB1aThkbngyZHBZc0RJdnVyeHBNa2VPcXpENFov?=
 =?utf-8?B?SUpPaTR2cmhyc0N6ZmRyTW84MUJlc1dvRUhtb2NLWVFydjFDZVJYU2c3TGF6?=
 =?utf-8?B?Z0tSdWhnR2JoK3BHWDNsTDRLWmRCRnRFb0YzWTBTbW1FaWRCaUMzNFlFZXQ3?=
 =?utf-8?B?enM0bEVjOWNjU2lOb3hESGNjdnM1UE1BRUZiMTJYRmFXb2VIQjh0cTlFM0RB?=
 =?utf-8?B?UFlCWmFRS0VLUHIyYW1TYXNlRUVXeWVkK3FvTmo5REVURityWGNudytDTWo4?=
 =?utf-8?B?VFBLaHBwdUhNQjFLQm5OTzBZeGYxRmVuakFPVWMydlR3emNtREovL05JRzJp?=
 =?utf-8?B?RVU5SXp1QzlMVnFUd1lEeEVQMGNyTjVuME9pKzNCU0NsUTNkdVdvbTcwTXlN?=
 =?utf-8?B?UWQycElQTlp1TmRXT1lBM3lLdTUxMGlYazk2bGhSM1A3a1lTRmRjdS90Mklv?=
 =?utf-8?B?ekVjZnJSVVpMcEtVSmpxcDVrS1dESjdpbi9ucEg1NDFOYkxIazd0NkFwdkll?=
 =?utf-8?B?UWR0N2pjSDQwcUVZNVZtMzdoVlpEY1hQc05ZZCtSZWJRUHE0Q2lsbXRRVmhq?=
 =?utf-8?B?RXZTS2pmN1NwQ3NnZ0Y3UTY0aEVVVThidmlwcHg2cXJSMFo3MENaQ0N2NWVp?=
 =?utf-8?B?U1NIMlcyZ2JGUFEwbnBad05sVDFxemEvSnF2ZGZHRkVoMkVrS2daZC9LNlNN?=
 =?utf-8?B?dFZYOWtaUXpBSXdzK2JLMVBGb0g3RXRlT2ZlSWpOTUxPcDFZNXBTbzJFWEJv?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3504CCC6C350934CB946277DC6797DB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dGq29lmXrH/JhD4OrSZnQKoUH3ut+QrtXoUQe9SSqusEfs7DvxxkfNavEDDVLx2idfZO805l/gkH5Zr2GD7fAguz4UVg/ZvPIziANOMcEyuZe7eM6TCaWnlLdWP98lNZLeyRupyiuBtMmvYZytmO+6RtldMJKZ3Vds+Qa8Nd9pjL1MhPaAN/FlGfysGafi1RCREgW/ZdO86rSIordiJFKDpPlShcLlzJdfyAl/WivNzuIMT+3ly5kFriuNpZjcugiET+S3Hx+uElIdKSLapTw3YD8t1Q2C0U54aN11BXw6GR0HfLeW05yz4ubykcXKR777mweaG+KWi1UvNaevB77NSB5hjZROwF1vzXtA5PDzGsC+7jlmLcMlEgBwSGBVLT4JdJRAh3PuDTc/FODPKiTrL4v3F7biGBP4VuGv5G0yKPLjQRbOYFWgHEkQ8ibMvu2Uho5ge/oXFmOHDmatTlTqxvvuRU7fRUf670NSjKw/yAwUhaLl42Td00H0JyGU9XzEoyFsBUTVxSXz+k23Xd2QnDbYSGaaIzfoMUIza7/kLKpRwZk01ju+RoWsM/Pq7AHbVp/FDAfYSzbSSXQHB8pZfkuRc8icM8S5B5qeGYuNodoD22QVNFi8dC+i4wtPiC7dQWO6GXaiflonLst3U5tPmFszPR0grAhjBJSPgKEug+uJoyey2fBcerRVFQ8wxwnj/3A2fwXDmCESY5klPo2wi9a7aMPlsOsM2ZWbcEeKmi3FM3oEuOzG4dJDSee+3vCo/O8KXBnEAmXyu6u4DU2/ZSYeTUPAo2FWKr+X0UgFZ26XYe2RR+bi6Mv2Pora8oNNBYuCmZL/QTlDAeYh+rSjx272zvO2ytmdT6b4wqt+jLFQlW7nGDzFc/HRHiiJoA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eccbd3b-745a-4c23-3030-08db5020d486
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:03:33.7501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mt/mM9xx8JOw2+pveXAhIopDld+eLxemjQv5J/Q4+sqq+y7Lth+ukpm4QvDXGlox1RFFuYRDMrg13HYn623M0MW1ZdWlQD27DgqPUeRw2Y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8871
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
