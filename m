Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3309960F086
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 08:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiJ0GoC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 02:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiJ0Gn5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 02:43:57 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0D8165516
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666853034; x=1698389034;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=WmLAfCf5U1ZMUYsVjnX2ARa7UxhQCOGUIzMeeLsx3aBO8Y4QQoMZmnZv
   m7N8eYhZnOjeNeHEJD7lh4ONUuvCMUgx2Ba+wbTZB2D6ZWN+oyyONJnbB
   7NW8w4zR/Knk/A9OHUsGgRNtsprpThSz0GDBKc+v3EgJ5iuf9iJnhVlOS
   XAzILJURjgzGmyBfqx1QV1KKZ83FGUwhJ1a4H7WV0cJVOjDoSW2jLwHgo
   c+unq5TYknnDQZM3YCCwXikNPYeEKc/Zk+4wAZxVEbiJ7MpZ/GkuC0m7I
   O9qspnAfZGTcoEtzJRPDAbtOx5HGUEwqe4o2XkKRDxJCPZ0iMUnQ0iAFH
   A==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="319177055"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 14:43:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLHlH8CVRT5DWht6yqN08VApyG3aN30eMdrkWzd+s7KWxBRN0qRQTEQeknEe4HboEiC8giU/gR3Dh+1mvJSi6VfF+sdVTR0uwLHhy1dLo7I2Co6oesk4a/9oHFzQSWaoQOxn2HapTwCHQ+5CWrt4/aj1f9aC+Dn9dWNHPBBC6ucpKLI1IBt1oHqz+BfKBz5WgH9ZpZGLMPdhnoViCyfRfTxhHYi1waJweUWQtANREvr9pHZXtSSHwIq0KWer7hmts/oq+DHWlihuMI10WS+YMlG5k8iMz8UwdGE5rPMyOnGBQnr/29n8V4aQ+BnDE4qvD5B6OxadxFOGCsg95pqXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Xl/v4XFJQDqaOw1D+kprWJxdw/HFs8fkrU9YxyRINb1UdzRJCSbZRNzjeFL4HitqeVDjsyx4qsUWZnJgl3/EWH17R7aljZwUzHj9DYNZXdFuyzC1TNkarGfL0KaFV9mYYKQkpEcDGbafdW7KsOpPKR1+Zt8iirIIgUft+jUsKKM3TckUHJ7fFMzGOCwDt4pNdG75SpzbIktaC8wh9wm6rYHAhqnFQQ39qVX3juDomXn2clMaeWGdQr3ctCLaTKP1slk6qkymPrFjUfhZtb5DAi2aDs3Bra8Byqhnq+qu2i+CZidcJVM8DUB3IO8DtvHr/Slg28T3To1Y+SxHQc9eDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=iUIxU6qKUp53pnbDICwF9TI/rDrobG30S9rMdQ20+Ed71X5ed/Ph3lNB4og1z+k6AhK644sUHcMr+Lz03YC1/HTU23Rh2/nC7/fdkfBwI4sPRpgrocFDxQuz4T6KA3KyKTi32sWjgTAoyH7V6m5GmU4aTAlntYTNPWQCc78sjNM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4034.namprd04.prod.outlook.com (2603:10b6:406:c2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 06:43:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 06:43:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 01/26] btrfs: convert discard stat defs to enum
Thread-Topic: [PATCH 01/26] btrfs: convert discard stat defs to enum
Thread-Index: AQHY6W5uS2NdaZL1/UWlkizgcwKvOa4hzBWA
Date:   Thu, 27 Oct 2022 06:43:51 +0000
Message-ID: <4ad2dcc8-291b-7adc-5221-48cb5ab09aaf@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <57bb11b786f8b8d28a91b031eae0d755e7a1ace6.1666811038.git.josef@toxicpanda.com>
In-Reply-To: <57bb11b786f8b8d28a91b031eae0d755e7a1ace6.1666811038.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4034:EE_
x-ms-office365-filtering-correlation-id: 5d0c81c8-30e0-4649-7749-08dab7e69c2b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: limvUXdH2PNC3ypjhvNsQzQGjec2YSuHrwUN6CQDIblHWuN97LKd6wBCBpVZCKTVTtqSWQvaLQy4TbFj5i7NjuZU9AAoFjsjKPAMhYnMyrQz5hpKQ1zkgj+Y2aMGnzNdIBu/SoOPzRVcOUb8lDNrNcAjSBIycVYdD7QvBcR1SCjRhR/D3pIP1AIAOZ5RJt0ihtBJLwS8jtyOPwtbf0VfPraLj/q1Ihi6PtqvoaLoFk1RFyW2y6eEaShuPr+hRMY5CvNCyHn7apImOA6VX2Qxp1MPQoUPlNN7vMVU6TMFQe4aT/qcwLZ7FmOoywid+pJLJX1PodYjtCHG2BAKFZvNktrjxsmmnScV6KV1urZwNvQLhnBeWSRi1r3gINxkO8BmSoDqTxqKgtNC0Ggp/OjAOBfs25PLCNWQoSlYTEQ271reXRUnIxShz7AdHSRCxhroqDCOK99Yo+dDCDUESeOLa+Q50EXyJ/vRwxpwE/ANxNo3EXN053WwG3Jeq5iqC/CT4pgTn533hs1C1Hw5MFIaJ6gBn645VJ8crXZZPkZRmVFP+U/HGc8iDHvowuVkDMF7RhMw2GwrCaq8Ne635doTPJxM+lt61i8wRPny7yslq527vAJwfrYeIYagba+gOR9KIbAP3HtKCuyegErV4bitYP+c627t34Gi/DiXIk6goC33mLzqXOEqdkF9G6kkBxcsU3c1w3uqrn2HbuqNcL0SKRsASPWuf1+DNzNCuG/04+OaMqHuS5PP6OGfbAPYFfIV56s8829wfcGSP/iyaEx86KPDO1WFyhNFfSOijSVyyKSWZ1S4lRRJkNAmYTCEA125KhHbmnvsnl/RgreAotZEtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(31686004)(26005)(38070700005)(6512007)(186003)(66556008)(41300700001)(64756008)(66946007)(66446008)(91956017)(66476007)(8936002)(76116006)(19618925003)(6506007)(2616005)(122000001)(38100700002)(4270600006)(71200400001)(82960400001)(5660300002)(2906002)(36756003)(478600001)(6486002)(31696002)(558084003)(8676002)(110136005)(86362001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUlqZytLcUIvbWZzYXV0bTdSdVFUSnNWODZ1VEFVYjAyMWZoK0tJYlgvSVI1?=
 =?utf-8?B?dkplWFFmY2k5WHZxMmwzaUo5V3lFNWg4Vy9aVWc1cGNQYlF6UDNBMC90TGNi?=
 =?utf-8?B?aElPWlNxTm9UeG5aTkxhWm02ZzVmYTI1SzljQnFvdEpWNURKdmVldnQ5bWhR?=
 =?utf-8?B?Slhwd2llQmxNenlaZ0lCcWl6YlRULzlyRU9ZRE1EdmdyWDJ2cHlQUVJoWEZk?=
 =?utf-8?B?L2VSdGM0OGE2WkJXNThjeW5sUzltT3Z4ZndJSC9ZV3JhVWhqZDh1dU5Yb3hW?=
 =?utf-8?B?Nkk2aSsvdEZQNGlRNzRsWlJyUkluNjRObUh1Wmh5bE0zY0loMGg4Tkt5NVI0?=
 =?utf-8?B?emR2NGsyT1FSQnlFSlU5Sy9hWUkwa0NWcUZpR3g5UXNXWmlpN0VEQktaZXAv?=
 =?utf-8?B?NUhBS1NTeVk3L0tvb25GeS9xUzN6d2xRWW1YeHJmN3VDT2UwV29OZ1NhOEFa?=
 =?utf-8?B?R28xWnJpbnpzN2VFOExRNHlKd0ZGcmdMQlRJbGI3K1hySmhzcEFXSk9kZ0xV?=
 =?utf-8?B?bEJrSXI4N0dySTVJckt0c1RmNlgzQ3pzclphQks1eDZ3cmFqQTQrTkdldDZt?=
 =?utf-8?B?NDh3c3FsN1JGdlpjVjUzVmhwVlRkUVNKL3pPQ2pReVBVZDl4STJqcUhzL04r?=
 =?utf-8?B?OXU2RTV6R1k5NFY1SlE2WDdaRnd0U0g1WC81Q2NObkxZR29lRVcrWVB0SUxl?=
 =?utf-8?B?a1Q0L0JSVGVJS2MxTHZwUW1GM1lsZndLZjdQTGc0aGZwWG5KZEs5d3EwTUlL?=
 =?utf-8?B?c1YxUGVtcEJucVJlMndEeEt0bllZQjFSYk9tNDdRYmlsdHlSbDQ3c3VuL0Rk?=
 =?utf-8?B?VUd5UmhBQ3YrSEJuQnJ4K2lET2M2UjZORjZjT2IyL3hRb0lKSi9OdHlDMXJU?=
 =?utf-8?B?R01ZMDlYL0RsOUxlM2hzUVNBTk1CeVRteVI5SWZkNW51V1JsSjZRZy82TmNJ?=
 =?utf-8?B?NVg3MStrS2VaZ2pOOGVvZGhsZlFqcjBlL3pLWGdRZ2xBZzhBMUplbmoxMmF2?=
 =?utf-8?B?dERkUVB4S3VpL09aLzZwd3lCVXhwV0ZIdVpXcmpJYzZtU1R6YVhEWXBFd3pt?=
 =?utf-8?B?azB3RDlmWXJQbkxRM2tndFVpOGVGTHphK2RZQlEyTmYveHRSOGRhV0Zlbzd3?=
 =?utf-8?B?czdJN21SYWp3SE1oNWFNMnRoM0VQV1YvWDhOUGlwY050RkJ1MEJ0dWNscHFt?=
 =?utf-8?B?dXJqYUE5R01aMG1qTGVjTzNkenZlcEZRWnpQZFIvVDhpRjZISU5MNmpwUmhG?=
 =?utf-8?B?SFBTR1Ftc3doWEtNeGZFeWM3VDdGV0ZuS1FFWWF1NFEvOWlUWDVUQURhQyty?=
 =?utf-8?B?SzZIUFN0QlduVnZneVF0SXZsNEU4bkhOaVI2cDFoSWxGdHM1U1NQREROUGgw?=
 =?utf-8?B?T3BmRWRydEhVSTBROUpFMndscnBoRkZTakVHNHpON3lmT0YwV25nY1FMS2xh?=
 =?utf-8?B?bWxJN0tjKzVPZTNqSTgwUThWWWZsUWlDWjVSZTZHOExtSEd3ZHlnZk5QVXBZ?=
 =?utf-8?B?VXdXZWtQTnE2emVEalhiVVMxcHNYODNGbng5aFZJS0lBaStXcGRyNCtpSTRE?=
 =?utf-8?B?eWR4N1cxSFArYWVyTHI4dGtrcVlyTHdiUmg0ejZvajQwcDY0bmdPMTZRL08y?=
 =?utf-8?B?emNHckRFcnA4RkxYcmpZTVczVVdzeXNWNWdDaVFPRUd6cVhKQlE3VXJUU2l2?=
 =?utf-8?B?emNtcnVSSzl1VmhYdFpmYkZGeTVHTkhXa2lOVkxqSTFoNVFKVlIxSWJnWjFj?=
 =?utf-8?B?S3Y0L3J6VW9rMlJ3VzJxT2VYejY3OFB0S29Fc3hUTGJLejBnSnhQSk1lYzl5?=
 =?utf-8?B?dDgzcjVHeERIa2Zqd0xBZTBZL0R0bUx5WDM3ZFA1RXJiU0ExM05qNnJnUHk4?=
 =?utf-8?B?V05WeW1ZS1hqSllCaFVxQUQ5c3pxNWdDcjNkazNFRmUzb0pHdllSWHcyYm50?=
 =?utf-8?B?VWhubU5SdGtudFVVMkgxaDVCcHhvS00rREhUZUZPOFlvODRzbGkwZTArQ1N6?=
 =?utf-8?B?dHpMT3J3ZThsMVNDWlJxWE5TeXJ3SC9YTXNDNmZ1bDM1OVBYTE1DWmVHSlNt?=
 =?utf-8?B?d2VzR003b3dqMXJ0RnNPaHFORUVMbFIrWkxNVXBaOVZxaWsvVGY5ZzJSc3B1?=
 =?utf-8?B?S1VobGFmTEUrbW1NeDMyYXpqU2FvSDZ3SEJYclR5ZGVQUEZla2kybkQ4SVg5?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70D6548004915D479816B1E706359A3D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0c81c8-30e0-4649-7749-08dab7e69c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 06:43:51.6645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gAVYyluPhFT7kSeXfU8GhUqP34wV4yiMAHtkhZ2Heo7evUZCco1N9s5QntBwtdZ8ZBxgx35EMyG9GddGMYrNawX51gm09QqC853TUAu1VhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4034
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
