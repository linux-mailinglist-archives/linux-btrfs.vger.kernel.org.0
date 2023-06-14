Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB94D72F9DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243408AbjFNJze (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 05:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbjFNJzc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 05:55:32 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0803C2
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 02:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686736530; x=1718272530;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=hl6zCEvVPAx47I5jLgus/QlAwfKxrtRC16gxC+0Tvdu3TJMqnJU6708s
   m7Kt0/dNSZHD3PO1lUbbwRQpSV6HuWTH9jlvquE2WDLgjK4IHtNTVAJVn
   7gNh0C1LHSNudXi16RiJEItSc66eqzyfQbyLWuh128zh/7uIuyNcxXPWO
   EJyKg+Mptmc7G6TrCltyjqWPb5+Y9yhTqEbfsCyHbqMg52DUi9PhXdCOq
   jt1au2fcH1dpqrUUCzKbyG4gj7QAdazCUO+6mt3k/1EZ73g9rOqEOOS9+
   wfCbuua+17suHsI3ZxE5IEw61mm0diVydZfeeXKuznE66qr70WVuaK5Fv
   g==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681142400"; 
   d="scan'208";a="233766661"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2023 17:55:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfKidWkuoAUZOwnYnLa/DcfxrZr5K4EJM7JzLZ3A0JpoOdJVoRVWVofBRaO9D1jfT+zsHV0Nmx0/ERagPygY5d9KyAWYI+2QPBdiFooGuxksVPVmzI+cVXkWH99VVsIM/nKk0vefhdqJeo4IE3vsG8vDnBEcnL5I5maD7alWu56e3/hHNlTzGqYSeg7ArzWxIIZUdR4ucBVXMa22HZxPsLPuWQ4kMp3q8XLnPsbzyLqVBl6Movn6PWh/yf9PaSf/rFSto4PvpA6+C2abiHf7oTdxuUz1Eoc2CXOdu7Tp+XGrflOdbkumjVhHjQWXDAvXvUZil05h7jFYO3jO308tuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FJzaIJ2WJubhBULIUIZPuOOifxopRfdI8bI+J6Pc8sH0wJ4bJrPcVtJStvoYWb+3DUGZ+tYo+ug7Bz9d59sMasCofW5XbG/Qkh/I3BY+9huXgZEdXRZ72iWWc6Gf1+S/bzsJiLbrSezrZbQ1SuBxbiitYh1LvdT0/Vr+f/oAVmI4HyCo52N471ma6n0dOECmH0veUynzftf7d4fqwujzhsE6k9mtY0WbTX4O4HxEgVshM+f2+3n3l54c4YNq+6ejIOCXzwg0dPQQupNRFaQXZkFeDjwyIyi+Ghcw4Up1JAxSAtJ3nvg75BS8jNxLGJ1i43B6s/lKbN35ohKp5cYKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=k04h7ZSes+D651WqTZN+gljjB+gWkAPqq88yFeIzB0Z0uVXedwTcrruuoeiDrmHb3c3nIc0oXxXkA7DBq+3iN2fjQFgh4jLsfsksKEebi0GpcZmbxPZ8hEmziXTEb1B/RsB6fCJ5Fd8sI2dxfv00UMMzCUhPAMlzQSdmTbwchNw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6450.namprd04.prod.outlook.com (2603:10b6:408:d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 09:55:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 09:55:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: do not BUG_ON on failure to get dir index for new
 snapshot
Thread-Topic: [PATCH] btrfs: do not BUG_ON on failure to get dir index for new
 snapshot
Thread-Index: AQHZng2rHpY1Ugla80KK8N1JuTesz6+KEJWA
Date:   Wed, 14 Jun 2023 09:55:27 +0000
Message-ID: <fbe4ac5a-a380-e987-8b4a-995b192c9ae1@wdc.com>
References: <5563d2c9f143485c62d3ab07446ed1f77f765a2c.1686670878.git.fdmanana@suse.com>
In-Reply-To: <5563d2c9f143485c62d3ab07446ed1f77f765a2c.1686670878.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6450:EE_
x-ms-office365-filtering-correlation-id: 87c04f4c-341d-41b7-cfd3-08db6cbd7b36
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzIJTIN7avJ81MMxF//53iPvXL6W9gh+Mx1NsY3fH06mrIXKJrDui5SWnqmac0GWLeCIOUZxkmf/nEWghhoFsPv793dR4Lr7kCIneYGofZBKFde/Ak4kwdkC7LD1UUcXI3rBeBjFFt8IycUyrB3ofUm3mRw6RzY50fsmnor6le16yhPNFmX56BQNr4NZOL0+VJa070HJVkqu3lSgI8QW9rIyPAZE1CuljIiH9XAFS5xmt7TZ+6aNqRA/vZ2qe2O1GAZa+JRccXWE5mzRcCSF90eWTAx9DwoPzr6pfOjtPhcYqVjv+bqhlMTtYnInREsZ8mDCDYGTHTGzVA2jzA3SKhJry64Aji+ZwhquRPHS7XDWq6BNpZdXh9HgmbazzUVOCM1cqetfMC/+evOiCRf2vfGjbOydn0b22xTVxujHaKx2Z9sJrSTJyHtmdA7mWc2gyBAPtJ5D+Mi2IYQKFIxvShdKCZxi5Q4tXPU7AI4BbuZLvBVirpZXej3fHwQbzkHOAxux7uPUdhwTgnr9DcRNREafl1eLLphxURBGJ9Z18mxpxyDV5iVpi9+RMVGARSOnX3eGoMleHpcz15Nt+CUvcD9x9LcOe2rKNxYuFNzC/QRN/wFzHh2F/4luznlMQTXPgkVCS56YesSA3bDEfKb+KgNXpQyAIzP04XNImZ+KccfOO68nREB8H2SgYaZLW/on
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(36756003)(31696002)(2906002)(38070700005)(86362001)(558084003)(19618925003)(31686004)(6486002)(4270600006)(186003)(6506007)(26005)(6512007)(5660300002)(122000001)(91956017)(71200400001)(82960400001)(478600001)(110136005)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(2616005)(316002)(38100700002)(8936002)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjB3dFFBdVd6N2p0ZGtHdGJVdWFWWjJyVnBpcERMVXU4ajFpVElhbXRXRWdU?=
 =?utf-8?B?L3RPV3NrekNmdTAwUjluZC9SUENONU9OZ3Nrci9YTzZKdmhldGNzQmNxaXJL?=
 =?utf-8?B?dFBvekN4U1hnS21HaE5xc0ZtOVdDRjFWMVJpZUFJVWRmMzlKQmZsZUt1OHA1?=
 =?utf-8?B?ZUVDTDZpN0s1NEk3TGZodlY1TEJpVTJ3K0c1MFVmUGRSYTVweWhYa2w1QnND?=
 =?utf-8?B?T1h1TmtWZDhXSzFndmdWTFdHN0M3UkRjQXpEc1F6K29TWnNyWTI3ZUgyK0pX?=
 =?utf-8?B?WEg5SUdRYmM0clI5aDBUellSVGZaNnFhZ2F4c056Zk9wS01nS0RjZlVDK0dW?=
 =?utf-8?B?TmxnN05aanJMWFVCWENnSTBTWWM5Tzk3NncwNkgyUFlGME1ibGVoaklWMStN?=
 =?utf-8?B?d3BVSnpTNk9jbUZXVmRFSHVzOHlkSWxNOVRJNGViUzRpejlyUlB3b3JuNWVK?=
 =?utf-8?B?K3Zoc1ZMYjIrdjRjT1haYWhHOG5xYWxKQmI5Z2pXdndpYWlaSVd3VFpUejBp?=
 =?utf-8?B?Y3Fic3BwaG5NSUhjM1p5LzRodEVSODFMMDhta3F0VG00bjdEQXJXdzF1cnMw?=
 =?utf-8?B?ZERrVFVUVnpIRkY0eEs1WDM0dVZDeHMzY1MyRzM0amE0ZkpMRG1WSXRKaUcw?=
 =?utf-8?B?TGZtQ0taRFMyV1BTVk1jM2xia3pMQlhWY0QwdjhvVmRiVnZUU2RpSmVQdDdz?=
 =?utf-8?B?Sy82Znp2S0lWQXpCV1JRRnZwbVpEZHVLQ2pHNHlDWFFDaE9DTGFSZkM5cnc0?=
 =?utf-8?B?RmdBVkZ6Z1hPUXdCZ2JzaDhMdWtoL3ZtaFZxYmt1bG9OQzkxdCtMUlRBWHVN?=
 =?utf-8?B?ZWZzNEJiSmx4TS82SHp3eDlMSFhNVzk1WXVFeExxOUxORlRJZ0tRUDBxdlRr?=
 =?utf-8?B?QVIyTHViQ2JzbGhuL0V5RHNiNktFdm9kdDFKTDlzRHE3dkxBT3RqK0xVRkNX?=
 =?utf-8?B?Qldvenh3cTBCdW53MWVZSUI3bVJyOGsrYkVkRUpGdTFCamNhR0JpVjVmNzFN?=
 =?utf-8?B?dlZMODRtOEMwUlBCOHBJaFJibW9LdGdPblV5K3ZEN1BrdVJRdFpURndIYzlI?=
 =?utf-8?B?WVNsdzVqcWhTSW1seFZ5OXFpcmRlU2tWTEdGbXlBZCtIUXNKQU1kTHZsVTFX?=
 =?utf-8?B?dkY5U3ltYitXcUYrdTkyak9jaWZwaXFiMGlTQUJwVkwyM05tZWxHZ3JjOHpW?=
 =?utf-8?B?M0t1M2ZBd1BJbnpyOXZoR2VlbXlpLzNPTSs3MW5qT3Y2dENWT09zd0ZsQ1Nr?=
 =?utf-8?B?QkhlM3YwUzlSOG84clorYTBHT3ozK0hKUXI0Y2E4TTMyUldIRHVueDYwbVZh?=
 =?utf-8?B?blJMVU5NTXZRaUJGakdBQ01LVXE5ei9zOGpHbTlyOGkwZnJ5MWQwUTFSQ2hV?=
 =?utf-8?B?VFFyVDhDKytrbGRMeFlGRkFLS1FnRXJnK2xMVDZ2dnhUSThNdkVadjBlNnJH?=
 =?utf-8?B?UFpNWHBqdXhxL0g5WmVrN3pjZ0FUYzhmdy9WV0Y3Q2w4MmZJWkxuR1ZHRjBx?=
 =?utf-8?B?WTh6d2FhRnBidHl4K2l5cCtvbnBuNGRoa1JoU2p4Y3cyWkdJb0tUNXBNd0No?=
 =?utf-8?B?dWlrTzVnZGNGODNPVjhPcHA3S0Y4UTIyamdDdEdRTlpQMzRmS1FhdXdXS05u?=
 =?utf-8?B?RHJmSWt2eFBRNlRqUkdVRWNOc29JOUJiajlaTitHYVJVaWNnNENXR2x3QURj?=
 =?utf-8?B?bWU2KzU3Qk5Ycnc4aGFGYWpSZWptaTdRaHVvSHRxU0FleC9zamNHWm12RFg3?=
 =?utf-8?B?VjUvcDZYQTcwU0UzWVEzMnY2R1htNFJaZUdVZ3J3VmVPcWQzdzdGWC9YUkFp?=
 =?utf-8?B?blFCVWJEM0h0azVBL0FsVTUwQVpLRHlsQVdaQlBHdTBYUi9FYmtQR2dTOHB6?=
 =?utf-8?B?cm05NXVnR1FtZE85VHR2M29JVjlNZFZXVExYczN3VnVXOWpCNHFYaXBqbkpm?=
 =?utf-8?B?L2tsbXIvOVhpREY0QkJlRDc5cENIRWFQbFZTNFF1NW5Fd0hVR0FuZWx6eGhw?=
 =?utf-8?B?RWFvM2V2Wkc2OHlTMWZnbDRkM213bE5RK00zU3dtQ2NHc3hzS2E1SjAydFN6?=
 =?utf-8?B?a1dTdW1BaERuNDR3THRhbnF4MXZ1RUF6OXNvZERpZ3l2d0gwNFNJZGtPa0d0?=
 =?utf-8?B?OXRPYnhTUjA2WkFqUUtRZ1kwb2QrdlVTNTNiL3NRaGphRTVjT0l5UTlXZlFw?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5AB136E2930124CA198FD98A76812E8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j2BiG7XRhiAbiEeLYnMzgE54vBcHu10YLELFWE4gTfAU7QD+dNtHYs05GjE+eT0QS+nxRY4fk2AxL/lu5N3m3xgIfWTwbFs+ThksrOHlrb0W7WRLQbm/UUPZb8GamzajCSACfFdt561AAmIOg/iECz42uLqKF47YJjSaXTbErLZAjhpmYlvlISmn0HuX6JW8MDa5vUV14DFu71nWgWkLxBlfdfuSLaPBHtrJY1tNj0H0DfX9Ni0gpIvZ3JOz7WSiuKerEV4+SPk/27sf4sZpmqnM9/8mk1xL7lGAysAWeu5zeS/7V1YbuDwnqqFHUhLEJxtXMpWz1zNpYS52OfE4JIEEe3/ZUJ6jTH0uTRpRrHur7Zr4UDbqIb4hl6BjzHYaowJPRK9xPKa6ucACCX9GSoaq6AECvobSxE86shrxhrTqCUdGc1KY+4nHqpr0USk6UwGPSfKmkZ4+XeHmrgim2xn8MXB2qF52nyZQW6C6nVW7fUsHHVglLuU/O98pOfveDP2GfDNXi9Nya06k/9PwU04DDHB9v2/TzzPnp+soloCGJDKE05QtzWN9JB3ThN8l4xQLT9FaCrLK5KfaPgN0xrnTHZ4VD7UhajkGDLv0vvocYsm6W3YgHl5VFmTrfGNye3kbDFai/KvQHnAaaHnRtE1MARNwSMpIgIabl53GRITO20WqJa8/ZrKBc3ELBKnPilvFDAUpiZjgtWqVHRGM19u9IYkOSnhYv6FPEKeNz/1FNJIEQ1+2IvVbhPFbxveDokjYRyjfyci77KoVTEdoSJDlc0wpHBaslY7PNY9HxwJvR5tPtK3vjtzgBZQQiTOw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c04f4c-341d-41b7-cfd3-08db6cbd7b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 09:55:27.4833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+/ALamFoHPgFJyabJwcrU/tU12WuorP/mcatEPdPTajyjdIhI2sDYQGOW0Z0+S1DsNOzsMA9XLlNAZ3JOsZFgJF3MzIAyNlapzt4ZulnXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6450
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
