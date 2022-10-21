Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F526071B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 10:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJUIHm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 04:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJUIHl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 04:07:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C02A237F8D
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 01:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666339658; x=1697875658;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
  b=n238PQjCfEMT6t23Do3ncHsQMFRGPb4YbcqVs0cJjKcttcNCWm/pxxEX
   FbdMv3r/g0r02Z4oTySgKDpbrm/dl4OUbLvwV0UrzeK0nZXeUGKj9vJeL
   4OFTPBCvNqJPCRe+nPm3eskiUXAPMyw9dS5K8zRM0uWNTfJEyLWcohW8N
   v1tJf2EyTiSF208uU1aCVmtyJ92mjNGixdsng8QrdUgMSJ/COiuZIFC9+
   +uyrnZTWz8b6IlTwGZiSH3OXIlgVwLmN52XZjKeiSpB57s1ZY9ZQsmHIm
   Y//vljvSVu9AW65VcKlN3UcnpgygUXHEi2pZDZ7Ggi6pDuQ7smsnp0qMe
   g==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="219579229"
Received: from mail-mw2nam04lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 16:07:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJtJNjPKJ3s1t6WAoukSSfsO+TFfZTAyPrZbPPUqsW6NIvc1jNSDT3qlN1ikNeCGMg3oIXTYnNu9oHNJE++K/4iNVUPYkvrlD5FzOuB29YrSJSGINzdYnz64r+WjwqApqa5B+lFeKng8IQHpXTx2xhuT8Xb6dxBel6TtVrdJidPp3+sehHwjVvNK5p0S7BNOZmcPJvwW3omqA/0Go6JjLE3eN8JsTtzHc0d2tSNMqiLLggOWJerO9/ZhYwyqjwTwd3Fg+WByk02vNsYCDg81+wk5duYub4IaUBzbwLYMEC5CtCaCPxzKFsH9be0vnNV1YgWJeXgXGR6M5fHPqPejrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
 b=ZszYkA+Uv69OuVgMPMeyPamVM/E4KAMlnInvOypGko/UG9/O8YHbUmbMvMey5qB44svMtjssJFbio0zcqKFHVGLersldm+REXCjkk87ldncsATYzDrT/pHRw+R2uDWxug+GDitvzM1rZ3+YrTIP1k63dBVKL4PqTtHUWSLDxDSFbIcAfTT4/Ih8XAsv2X1/AXRAxW8mbY0hg1Pl22osc1iqU0uGIIuS8Wovb6Nzjc7j1zYqklo2Wg55GO4wnO2ZreipNucJ2Q9ONubVyLwjeZWIhLb91WIsLyh5Q2NX8rNsso794WZZOtWALGCPRdQp9vi++lwCJVQmeCWmVOOGgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
 b=hgewY4nwMaot0BVpqjw8ITDnPGtCm3QUqXAEEwNHQIKZSOYMzP46oV4G5YrxO/o+INUPL4dQriL1lJIfCCEYGoqpmvpkl2rddC2hj830iPwJE4+yrCLYJ/9pD1KGEVn1+cqUToGC/2w4QHeABv7l/88xQoL9M3UZ4YVILHKDZwc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5674.namprd04.prod.outlook.com (2603:10b6:5:162::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 08:07:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 08:07:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Parameter cleanup
Thread-Topic: [PATCH v2 0/4] Parameter cleanup
Thread-Index: AQHY5KWKj+EFdKrOVkGmBRgjYk5lp64Yfw4A
Date:   Fri, 21 Oct 2022 08:07:35 +0000
Message-ID: <18548c2e-57d1-aa0c-9707-8ef24568b924@wdc.com>
References: <cover.1666285085.git.dsterba@suse.com>
In-Reply-To: <cover.1666285085.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5674:EE_
x-ms-office365-filtering-correlation-id: 1d3e5fc0-04c6-4a15-4434-08dab33b500d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xR8Jqq09tTj07A0OHAegA2RnRN22dmzTAbm2Wb3dqlS0DjqZkLER8wt5GVc8nV5z9MtsJ6j1U1ofckiHfS4IfrPEf8bwXsvGsHDGLuYMPLgtA3Rg2vOz9WLeTb+R9L1pCUrj3HeKwAuyZOiUrILCNvXSG2JvLIKZvOC56L75GyQ/uO1OWIt2w0BF15EfqmNAwRjXFMMrnfTYp3RAZAi2YS3+j/TnaLQi+KtM7FKNwilpqI2cjsE3Z1X0i8OV7wDyHiXbHpDFlL5EA1nSH0+zpaL1XgTce2SBSIeSvUc9qTeezHiikvLBPhH1UxDTSREIOJhme2tTdTGHksPXx542fEcPUk3RdHlziMnO3bGBVOUo0eJYGrjUM+KGrzlAdjcKC72hUe1CBRFe5T+u/Kt9Z1oC/Ws2xyESCZIPnoFpJnf6siHOvjYcs898s0sy3Out/vKhIBY1sS9XyjBywfBpstvstinIcTKr6BlXeMm6vipH5zDlVr/1xy/NP1F0m42OC9WBnm67uauOp0zAwGVWD2raQw7tDqGKGliNZJ1w5la490/F3CsNeCwYC6A7zY70rKMu0ZphH/eypXHOS8NsWNvBYajCe5AthU+HD1lsQ21sV+tsta3wxuCVxFC3XXVuA32/1KfLh1b2RsGjrJ01XeHAOo8Z8QripKBcHM+6Zv/da1ns/LcqDNzybe7ClvoSOl1d3QOJJgNR978UKixxZ35YlmCaIBseD9cw2DPs3pS3Z+sT3FVXiBnTUur+gVx5sfkIjq2gtW4O7keFcaIrpLa8sT3JwZD2DdO06BCnuB1RaJjRNJtGkWwNsydmGDFQO9slhB+mb0RKf9d4YNYkVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(478600001)(110136005)(6506007)(66556008)(31686004)(71200400001)(66446008)(76116006)(66476007)(2616005)(8936002)(91956017)(64756008)(5660300002)(41300700001)(4270600006)(6512007)(26005)(8676002)(66946007)(38070700005)(82960400001)(2906002)(38100700002)(122000001)(6486002)(19618925003)(186003)(316002)(558084003)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE1TUHVHZEpYS09vKy94d3Y3MWpXYkhzY1R0THYzLzNOQ2ZYWnhkVXJRNWhp?=
 =?utf-8?B?am1HVVc0VDBicGlEVTZudGh3M29ONm9JL21GY25zNVpuM2xvY05PM0IzaUND?=
 =?utf-8?B?SXhLd3Q4dHZRYzM0OUhnVEw5d2ZoYXZvZTd5aENmT3lPMXZ6d01taFA0Qjhl?=
 =?utf-8?B?S2FVU0ZZUFJUVllBa0pJOXBVelp6MURaSzRYeXlVZUVyaUtoRzEwUFE2cW50?=
 =?utf-8?B?OTZwSDhnSXdkK1c1eDhDRkFoUjVXa0ZHMGVGblJyMHhURWZmT2p0LzRsTXlJ?=
 =?utf-8?B?cktWaXZwaWY0UnBKQ210TWNsb3NSQlF1c3FMU0NDZllvQTVPU3M5ZFd4R0Fr?=
 =?utf-8?B?aDh6NytWdGw2eHRNQlUrRWozUEljYmVuT25vamYra2xXWXEwdGNPZ290dXVC?=
 =?utf-8?B?cFpRZWlNWkIvNmNlMVUrUUo0MU83NldUc1RKQnM3RitmL2tQSTgzZy9DaTJz?=
 =?utf-8?B?eERibENiTHY1QTNvNnUxem9YSXkvakhrTnF5Skt3dHJhU1YxK09CdWdyU2Fa?=
 =?utf-8?B?WWJrUHVpVms4eEp4YXJVZFdzNnRDckRKY2FxbHdvdG9DSGtYVk5zYUJUQnFB?=
 =?utf-8?B?SXo1YkxGN2UzaWpZR0h4MlF6R1F1OWRqT211dS8za29UWkc3cnRLbklGODli?=
 =?utf-8?B?aEFSOWRDQ3RYa1F6WHVqa2pPVWdoODVEVzBKL01RWHRwRFJrQzJxMVp1RitJ?=
 =?utf-8?B?Qy9ycW9RR2VESmllUHlhZFhuWVBnUHh1VkVGMDRYUk0zZGN1bHY2OWVuVnJ2?=
 =?utf-8?B?SG5LUGxkU1NrbVVNY3oxVzlKbzVxYmNiVy9mNTNLL2UzNlNITi8ra2Z6a1N3?=
 =?utf-8?B?azVVcS9Zb09ncTBZU3gxRm9nYUtRL3pTeUIxdHRpN0VteXJnNzNEYy90OGNp?=
 =?utf-8?B?YTR4a1pwY1lOK0lXaWZPNGpZa0VTTGdoY1lCcFMzb1U3TmlmNERHblRVTkw0?=
 =?utf-8?B?NjlOQTh0SEJ5bU5QcEpNTWJBQloyRmg1VWhiendzZnBLbS9RVjdMaHZ6VFpG?=
 =?utf-8?B?eUZLeWFhUm9PSlB6WXJ4OU02aExpSVVHRjl3ZnRPY1RtbHFhRENta0JjcEww?=
 =?utf-8?B?Z2pFK0dZb09Ydlh2bFltalhWa3BIa0lWUUhQdm10SUJzcDc5a2lvS3RZblVK?=
 =?utf-8?B?K0REOGYzMFU1cDd3OWwzd2YwSi9tUS9MYUMwTTBraWcrUWFXSUdGQW9pZ1BS?=
 =?utf-8?B?azB2SjQ5ZmhLanNtTitPRG1tTEJINjZCMEhyTGp5ME9vZUpwa3AwN3VHSDFX?=
 =?utf-8?B?ZDJpWUh2STQ2SUMvTDJvZWNCaEJKdWFnMHE4Z3phU0lyaURBYkNNQnFXUnJy?=
 =?utf-8?B?YURwdkR4ckpkdXZsaGpPVjhGTlQwMVM2cXc0QjNRZjBwQ2JOSFpZc0Y3VFBv?=
 =?utf-8?B?UHAxaUJBRXpBK2l3aXZhdFdTejBaRE82OEJFTjNLcnBWa0hrYjBLSEhmdUJR?=
 =?utf-8?B?YnVlT2NsVXdlbHVEMm80ODNhcFF4c2syTGQ0bjhXZm5aRERNWDZRalRtLzhB?=
 =?utf-8?B?UUQxdlhpWjFTbGIxR2dmVHQ3cU5jaEFvazM2VzJEcUtJcFR3NW1MZXB6TGp3?=
 =?utf-8?B?ay8yL1ZUaTVEaWV1N0h4QjVOOWFqN2F0Qk1GSWRCWklzWFNZMzB0UDFXZXpS?=
 =?utf-8?B?SWlPQVZBVFZQQmljSEUvdE5XUWVCMVhFSGxhN1M3cE9hR29PUnc5Z2Y3MExx?=
 =?utf-8?B?cWExeHNrTk9uRUF1WWZZN0VMN0xsNlM0aVhtbkpwN2lpVENKdXBKcnd2dnVQ?=
 =?utf-8?B?ZGhEZFNJSi8zQTNZdklYa1BTMDNsQmc4Mmc1cnoxRmpadHdsYldIditwMWQr?=
 =?utf-8?B?bUxNWm1qT1p2cy9makdLTmcvTjhxbWU1TjJwK3NiQk0wWEtMYXlkR0ZZOEtt?=
 =?utf-8?B?bXFSZDhoSDhLVlFZQmZvNGs1Y3VibUJNb3BsUXVtSFdFaGhQaUpXazVnOEk5?=
 =?utf-8?B?SkxNUDhVMHM1Q1NrdXh0M3RTSmtCNDlSTFhwV0VES0FuRmNaR2lOMDRxZkZj?=
 =?utf-8?B?OVRQcjMyWUNFL000N3ZKSGJKS016d1VlK0I1czA3Q0FHOUNhKytjeGJocU5U?=
 =?utf-8?B?M0pTT2xUbStpMC9JK0dlZWNJdE9uaU9GR0lpZVljVlRBU2hpc1hvSDhVb290?=
 =?utf-8?B?YXVleDNtaU5STnp6Kyt3WXZCZkJiNXEyWFdyZU9CVkJTOG5NRnc0Y00rRlNN?=
 =?utf-8?Q?3aLn8w2EaqGFwCVC+Bnhh78=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8A43A6E7225D04CAE98FF7C206115D4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3e5fc0-04c6-4a15-4434-08dab33b500d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:07:35.3210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8NnNG/h+6W8IfYGTDOuz6c8qMXzJS6aoM2go/dQaMARmSxA9D8ElamxUaagYl+3aR6ukZhcbIiUYFqpuxtzFk406FzyMtZkWBKHctk+cXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5674
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Rm9yIHRoZSBzZXJpZXMsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
