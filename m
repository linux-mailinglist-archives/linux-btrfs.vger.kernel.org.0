Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6570DA40
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbjEWKTu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbjEWKTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:19:49 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C794
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684837188; x=1716373188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=eM2QPRa5hG///2N/UATqLbyPovBpOFuLaiJ32sCiQbQ3xZeiMa58W4mc
   JF7UApFkwjoyDfPvpplN+JQZYzE6bD44hLvk+Gm/l76WTL7CBKtLZw5T9
   VXJLaqVXrvkclDSERt4iQG39gCxkqOetVN1DjcSeV1MaWKUWX2cDUFFYm
   NaMhGyDg62zWwsV+CHkRJp3hlSpawcofemlWra1mU3CseDSiIFd6x8Hiv
   CCqz3bJa2GtLJ+bpWnr8vev2AXh4W1CoDaRdBX2/okGYoQrSeCObp2Gt+
   JasLIWa+o8tiW0OXExNkctmcR/Lo7NAn5lw2XC9nNX0ptB3JYmzKsYVu+
   A==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681142400"; 
   d="scan'208";a="236375493"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2023 18:19:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XePSzNb+oKXF6f3d24g3xhevRENJttS9rXUk/yoCL6K9JRATdH2ogsbd0ttt7yOnjdhUYdfEuC2H9+ZErKVjVEtHJfz2PV3RVn6lWQMGWN9CGo2P5KzuVOB1mWLklnqXOY4q7eprZ12BBGZ0zkecKOpfaSWSnLU78OMV/qk1R+j+xUJHAhWpP2fIzDRTU/u9IWP+KUAwU1Rub/z8skKcvXHEmBvwYsM5SjbNoTiCQKZVDVpHn91Gi5Wc+sek2WjjQN4TiFaN5cPV2fTFO86cMxDhBijkwjVqqo4q4J5g+IvmMop6I7WOf2XVXpHhDif0u+fqQ9gV7mBECex8cpyBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=es5bgBt0zmYPIPxoK7FbrhfBWRWdC0dE4DtggOPNse0s4sUMW4jOQGZchCf6hYkHQdsk/YiqF7B3WalLkyIQNLE/w2oOHgjwRDUDJ0sfZiK46yM/X+SXfI7j/Il20UZ4dYfi7xFDZFpECnu3aonc3E06NHK6jnlQf1PMNx9kdgtGqBwSwTJuT89ya6xBdD4OiWPCRwL33tMLBGnYu6COZ8jKn3kELQ+BxraXkuV0rIuIKsIP7XvQ9PhbGMSUQbAbGEFxIh/Om1ZOEYPYzMcQoP/yGE1b40P0iGJDXlkz/CRWXCa6zPlPQSkymR9R8mg65bx5cMI66XHe6VHFuOOIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=u/X2rYcXpx6/uXMkJymLaQMm5IkC/HMvpCQbpk1q+fgrSAXqT730aWR8BZRVuJZcyxpeZ0wbfGD7SaPGCJxDjiuD2h4M7KICJ2DLc8w4r2eu1V9tAkm6W44P3E/YrdmDQj34rcfVldaCbcVAuB5DWxCq68ZeRm5kc36OwjWdtRk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7673.namprd04.prod.outlook.com (2603:10b6:806:144::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:19:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:19:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: convert btrfs_get_global_root to use a switch
 statement
Thread-Topic: [PATCH 2/3] btrfs: convert btrfs_get_global_root to use a switch
 statement
Thread-Index: AQHZjVJ/7zkvx5XhCkmmwVKdsK6zoK9npYoA
Date:   Tue, 23 May 2023 10:19:45 +0000
Message-ID: <30554361-29b3-557b-e265-d08a8f70ac51@wdc.com>
References: <20230523084020.336697-1-hch@lst.de>
 <20230523084020.336697-2-hch@lst.de>
In-Reply-To: <20230523084020.336697-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7673:EE_
x-ms-office365-filtering-correlation-id: e25993ee-02dc-4032-869b-08db5b773afb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5jrl2gkZI4akt4uWHD8h5KLGkUNZOz1qN+2E+wDK8VqYdUFObNn9mYRVqyJPj4WuW1z3QLEueK7Z6X1Dgvfa6mwcnXMpdMWJakpg29VzeMsdTXm3018aQEHpxLV0I6rtBRSbg6V0YY2wTz4+rq7UNjJurvK0DS8qpxVSxYKVe3vZuaYGguIKdv5Ha3nP426wEpux1n0w8z2+jRcftKvh9zpzxwjHlTw6eY1aZY7gtNk/y7ouYZW7YXYVqRpBDxWeyHquI0rhVv+HceniGNKbfDpJUYkf85uIxbUvFa+MTpJxATkjeT5Q7lXcKeYv46+i5Rt7eJuXaSoe2qFq0K0zavTiG65gT6sKT9BLcrIPgDrIzRIcC5jopPPW+FqEl7T8DG2fTYLTQw5zc8USiBAaLSNafcb01QVdQfEtAp9ZV4CQ/LG4XsM/N6YOziGMkyhvRwjFR4wfU3AfK6ioF3NExp2uSBI//+lyv1w4mQ1NRjDB7+FbtikCCrSCBuC7JMhPLgjgeZHI+EjlfNi9lMj0tE36N5/dhJ222/p48derWUDB8EvFIsNWKDMgNzASOI9WVMTEcNQZfxMSbmWqCjQgzqOt+hoz9ZS4GrfaQa7pWjg37wBY5CYYOg3Rz2hczZmzvcpuqRFxXsppiBoC2J75PT53e3xSbm4KA4eVgNMkzj08fz8lNQ75zxWMRHsdjijk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(31686004)(478600001)(6486002)(110136005)(2616005)(38070700005)(36756003)(31696002)(86362001)(558084003)(19618925003)(4326008)(186003)(4270600006)(6512007)(316002)(6506007)(71200400001)(2906002)(66476007)(38100700002)(82960400001)(122000001)(66946007)(66556008)(66446008)(8936002)(8676002)(76116006)(91956017)(64756008)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnB0SFZBc0N1SjFjQi9Ra1VlZ2kzRm5nWlozSFV0Z0FpSi8vdWw0NWI1K0t0?=
 =?utf-8?B?VnEzNTkyUEhSQ0hwWHhPc2lOcGp5Q1NQUlZRWUgybmpkS0JzUjZCTnJwNk4r?=
 =?utf-8?B?SXFCVXBDRE9KMXl5TmI0Z1lqZE1LV3lhM0JHYWI1SW8vYmNnQ083SGFjbEhD?=
 =?utf-8?B?ZVFQQTN2NzlGTzZ1U3R1aERJSVQyQmJ2RERoNE5DYlNYbXJ0SldXTWZ5TnJw?=
 =?utf-8?B?OWdBekhRcWZvVXEvckYxUHRiQ2xLTDM0U05DUy9UeFU4UWdMSWwvM1NiZWhN?=
 =?utf-8?B?Y2h2a3VPR3B2STFSZkRHMjA5ajl4cWdYcmpic3ArSktNYjdUSGZIdU0wTmVu?=
 =?utf-8?B?aHBXaGRFUmhEWUVqTFJ2cHNJS2VFNWc0SW10QS9aSTBGbzB6U3JIVGhUckNE?=
 =?utf-8?B?MUVYMjNjL1E0R1ovYmJRck16MGsxc0lONXExUit3ZjlrWmlNOWs1aDdaeDNN?=
 =?utf-8?B?V016ZXVmOHdud1dEMk1LR2UwU1o3SDV6elYxWWxPc1BSUDZlb2lvdWVRM3ZP?=
 =?utf-8?B?ZEdUQm0xUmlGRXFGd3VOeGFJa2hSRFZrcEdFeXQzREszRmxvQnY5Y2lyZ2xB?=
 =?utf-8?B?dHMvaHVPc2FTanp4S1RzWTBVYkNWV25pZERWTkZiUFJ5V2hvMSt4MFk3eElU?=
 =?utf-8?B?ajJGSEJzbHFGN2kyc2Z2SmRBdGlGVmhwa1h0Q1EyWGFXUFJOc3FHc21OSDdN?=
 =?utf-8?B?MVlEdzVsWkVSMUlXUnV0c1ZFVkZLd2xndjZDblVUZVRWSmkvYTMxSnhEWmY1?=
 =?utf-8?B?SUVraW1SSUZOMS83VzRpSmZyKzlNN0ZaN2RtMFNrZEpWTGlodERPdld6bVpw?=
 =?utf-8?B?UVV0S3RvQm45V2JsVzRFZ3ozQ0xFOElXNHNpMm9zeVdEVHRRMnlabDM2aHJL?=
 =?utf-8?B?KytNc3gxbEliZ3dUYkdZVUNRQ0J6OGx3bmt4QVZyUE54VmN6MmQyWHZoeGpN?=
 =?utf-8?B?SFBiMTByOHVyaWpick9tQWY5eGREUVllM3FKS1B5SGY4amV4c3M3RnY2Y0p0?=
 =?utf-8?B?bHB3VnFWZzdsWEtBMXFyLzNoQU5XZk9DL1k2S1JPOUZETmVxZS9WaUlaOTA3?=
 =?utf-8?B?NGVFNlI0VkdXRWpzYy9KNng0YWFZYVVySXNTQVlxSmJ6NXNWeGxGOTNDRkt0?=
 =?utf-8?B?VHhRcXc0MjFxTlZUdnl6SytZNEhYMVlOdVRjSnBDWFpLaFNZZVJ3MUVDNGxs?=
 =?utf-8?B?YXZjcFBvRHF6OVBSN2h4TWxVaTVUUFdoMnFwY25KRzNZZVhvNlphZk43R2Vk?=
 =?utf-8?B?TEJFUUVycy9zOFlnRjJPeDc2Y3A3VGdETkZqVXYrdXB2ZHN6ODArMklVZXRa?=
 =?utf-8?B?NUEraW1lZWpkc1NWT2pQYlU0T2xkRUtZSkM3UUl4Y05aV3ZyejZ1RzlVYVM0?=
 =?utf-8?B?eWg4MVdGR0o1WnRLbzcwdlBXWG1pSjI2MndpQWgzTzRUTXR4ZzhqUG43ZHNs?=
 =?utf-8?B?NU9ZMkQyMEROQTIrZXZpR2hNUXZNNHRYNGVtR3NsM0M0dG42K3Y0djhoVEkz?=
 =?utf-8?B?cHV6OXozVjVyYmExT2p6clNoTTdFNmo0QjRlVzBRQVM3T3NwZlZKVHVaaGFQ?=
 =?utf-8?B?NVlZNnUxZTk4Ym1TZXRpZTVIZ2pUdGE3VDdnbE1xRFlmY2pBMGQ3TDlBa1lT?=
 =?utf-8?B?Z3gvOUFsdjB6YlE2OUxtWjBoWFlWMkZiQ3JnbytLeVZIYm53ZWU4L2tISnBr?=
 =?utf-8?B?eVhRYWxMaHZqOWptcGpud0JWTExzd1ZpbG41bHorOWluc1BiM0xBaXNQZUZr?=
 =?utf-8?B?WXN5QmtsM1dESFp0c1JDdVlycFJ6SmxoMldqcEtSSUVyam9ZR3o2RWQydHox?=
 =?utf-8?B?MW9UcVdGWm9qSWV4UGJydGVyUkprclVkZVYwQ0h3KzVJQ1U3R1VVelJWc3Ur?=
 =?utf-8?B?eUNCbldrazNnRkVCdHQvWjg5RWgvdVRQeDlVZzMwWk1jeGJMRU01WTl5Q0R2?=
 =?utf-8?B?dUpsaVI5RnNmOXdSQkFEY1kwUGlLMEFFZGt0c1JRdUE2SURzd3orOUhvTzVq?=
 =?utf-8?B?eGh2b0JobVZrSWR1TDhPaXlDL29mV3pac2tXUnJ4dkh6VmVZOGNkb1RRYXJt?=
 =?utf-8?B?QUttSkFtSUttNEtFS25xS2ZYY3I1REhQUUZybStyQ1VQT0g5bVE1RXVLRkQw?=
 =?utf-8?B?aEJFRGFKdllPaWo5OFB2TUR1VW5hNDlrS05xRThiOEVEdFFZNXFUSnRiaWtN?=
 =?utf-8?B?NXViOVlvMjZNUmNXNElNV1N4Q3I4YVIzamZLM3ZsNUV1YVNtU3hKdk45dnBj?=
 =?utf-8?B?WUE2S1Y3MUVCZG83Y015NXMwSk9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C51FD0119679BE489389BD21154CDEA7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SICa8AKU+99QeM/MzEqHu/OHE2REUf6RekaEFkSel/wvOumpcd9sZaK0gIN4J0D4FNBrYtkzYfd9PPqWfp98mmfsgbQtez2xsh+9sJnHsq4DxMqrVW2ExAEXCUZQRKrpWNxyW1ShyYnnLOakWTTybu+pXrLmfjJ4pOJ4AKGKbHnCA0y1UYdocoIk8c8mwijCEvxyJaM3jL/gYAlYpo4Gfw4XOyNbdZwXDE6RJ458nKX8FpQSg246LakZthy5YJtudt7f3613ZisnsGabwg9IQydrnxZ/YPIqOlTthF4I4zBjvhL+TMT3bwnYMXSa1BokQYEF59mcSp1XqfFwOKknsH2z9lGxJpVs/BK9cJCcQBZ1dQ1FDDV6nPyjOQZnm7bQk/Ds08tIOcIYpNeqofx5lByuQHfna8XGGEOMfTnUREkLWqKNdn8dM3s9I99/uP4rtlRCmHJi4cSCznHOLamDoAMgfyZAbMsld8QTjzrYWVX3DC6vpjq7evWVf4brJM9ilFTHVLFg08BfRHd4ke5UVohBtYOW2hN7XrBdd6KPxgdUyt0IF/01tKxYaGEPS2Y+Pjbw8d6URtuKe7RD0+813dstkBbVhWzD38oOy9TtBNPJizpeAp9acfzh9B/HW20YZaZOEkbfZYXWj78mMuQiI6qVe9DmUL765oUyTOxTDzVi86qf8a0D2ViMh6YGg88KzlGlwFF5Od182yHZjMGzpkfA+mhYaV+MgNiRpYNoc+LpWhDjfp8wwPUc/iD6/nqMDYV1glBrcH3+vJO6nRZvnqrDtXLPFAkzQeq5e8A/tP8aJHhYb7Lhh5FADRc6NyQdkvSVcGqjzsIFCxdTlc60Qt9getxp2fqEcFCF+Sqp25X16GEWdJ4Y0zqv5d2aFvhx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25993ee-02dc-4032-869b-08db5b773afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 10:19:45.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppUBCGxyTQB9AqCf2jz+Pdq/AN9pIxIlp74Gix4MztfIDuFb1qyE3dmV2q2A5iz9/gscirVhXQELEsDjgHqkgNOa9ktcCARa+njwNOleD3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7673
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
