Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01250691DAF
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 12:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjBJLKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 06:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjBJLKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 06:10:19 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A17101C
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 03:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676027414; x=1707563414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tf+vjvL671ud234CsgWN0jyLlj/Ix+5gHaDRPRipUa8=;
  b=ii2MIcsuNlvLor/Hk7RcQvNPHtYMH58YneBrh31RFYv2EPkqNHfa7FG5
   GkibE5yAmc6S0neqRke5P9hGT4Jr5RVG2oIh507ZnWTVJfahjYNIZclVN
   cgchBn3oKee4zIInOVGZwTXpTi0Ir/hiH7MS2AB3XknyOTQkWj5ZxCcIC
   5kCn62fV20CS2eEtU59dCOhE60G7sYeSMLP2olIoAy0VCy9318pds1TMJ
   Er+dFZKzZ9oh2iAvwMfU8kowQa7nx+b8F4ZO3l8wHyvs+g8Vd+4fx49Dq
   uZZ2AWP+wCQq5W+KDBH0KI8s6GqPZjteYr4EsdbjhhXpDCnvKtPZ4aK2Q
   A==;
X-IronPort-AV: E=Sophos;i="5.97,286,1669046400"; 
   d="scan'208";a="227967262"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2023 19:10:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THTl3tECpcdsTkgl0opG/ZX4MKbjeaz/POrO/k4VlHbkkrzzOwTSX4+E/K93Pmvcv7PzSQcE2Tszel/InM2pHbGhFCde8ugVKNdNr653KovpkdpSdbSKRlX8eq6x9fEmX66xRuzm3+EhJu+NV7auXmHqBs1sYrDSW0Zd+VBz5iYbkz6wcSCkLcMOniSafyaRjlqo9umRCc2UvY/+8dqxVSCNfu8Ck4mD2IRsUfGxQSr2zDEefApCcDcb6AtXXK/9K+fuceAivKc0hqGELfS4lh2UjctVjybbUgaT6SM2ZtDIE5vYQf3F/UBFfs4Xn01YxJWZL1a//Frc7RWm/saxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf+vjvL671ud234CsgWN0jyLlj/Ix+5gHaDRPRipUa8=;
 b=CZRmiDDg+iSoubNeki+Mzq81pcpEe7vRPwUqJGarx8j540T5OpJ9VOS1xjPDo47NctUN30cYHWJ5RGk2yKc9tcpJXZ0uD9mVk5UBpCEOyJf9nyVWUFflaPnXuLgr6dmYzcpMZmNXnOO5Jd2XrkeJU52Qvfp4icCboLXVlkSL4GwfFlpQzHK6iJQVZFZvA3hgSoDI6EeTPubGkHSwTq6BS7hASHXiJerMo7wulEIn5nUhDFdXNiuUvmQpn2ai8RybqRctlJ4tw1kdWMPmtH6/w3SGDkTubz1MbDxsq8kqykf64g7Su2IMX6tbG7hZiv+f/shvNZwyyZSK8QC9CROBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf+vjvL671ud234CsgWN0jyLlj/Ix+5gHaDRPRipUa8=;
 b=ODEcmTNyswD7HIAznyo4ul9zAP17LwNCZcI0OpEs5FhLCOM9nmBIxzO/ARMzcPcn5ZAyTL6FxRBN53eq1sThxY1QIE6EBPV+8enBrxuyGToJ2gFb14DmfqnBWueYG9zWhDG0KQztTg9OZ8xx/exL/G4Kx5xDzSR0RSe5g0oIHjU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6121.namprd04.prod.outlook.com (2603:10b6:5:121::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 11:10:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 11:10:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: compression code cleanups
Thread-Topic: compression code cleanups
Thread-Index: AQHZPSQoaQBWv3B9oE2CddSKu1uAhq7IBjOA
Date:   Fri, 10 Feb 2023 11:10:11 +0000
Message-ID: <40830d3b-636f-1807-6268-8ffbefa8b062@wdc.com>
References: <20230210074841.628201-1-hch@lst.de>
In-Reply-To: <20230210074841.628201-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6121:EE_
x-ms-office365-filtering-correlation-id: 0a1f595f-5f0f-428d-387d-08db0b5760fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: afZaX3XLbmXdcNe1e8rnDbqiGxiL3knlC3aAO30vjqvnpgQu096u/wCVQ3c9rNzL1R68Ps4PCHGjZYV0BCIzSxaDZbliqWh5awwdMMS1iXUG+5pyMn2qcdVZcAY9zbV8XFTnlyMt47YNnsqTM1t5RaOO+AXtSLKvkOHgJnxfDfsFqiVBfWbZUqpPCJy/ZJAcT8ocne6r2tGWOK5u4+gjR9n2jKEZpeJcGzrT2Lnwg2BpKVFkUKKFGVNUi1BcfJ9lQuQppn+G0PSOL4hrSDb0B4QwUvO0vgP8vHgHJWaLF/hO7hLxt3snprMMG0C1GW93x0ZpSIJILkto0AtVuAQ5zw/SwAk/oTHJ/sqqi4+ThuTOn2QcwIs03akXqLAjQQTee1Fy+6tp6rRIHxArDlvn4Q3GXakXU7zZkk//Yqoj0EXHtyWDEKDwfRbQtPRRNmxGbzzEn7YYzKsR+fHHCUtRGZng7Bd0pl5ANg6SSoiOTA/BYSPUjsIlQdvDOBQlCgSndtF+1CiiwcVgP4YjhWNLt/ucqWYxPnzAgzaFhd0hY5ppTwik/p2cVLlwWWQIxSvQk7zdTzhPM3GcY9/Bo4HXVburbwaOSnlmOQ1oUi8i1yD78cYNg0S+12rDtLAEY8Z8RQg43HHRlpCi/OEy1wqiGobNVlYbG82zkoRbCiMlxofAnlJFOrqoo1Zhx6AqYWZROC/o5DufoOI0GK97KsqAGpvtj3NZdg661EnYJ4kyGMEG+Jtmq4cWdQs1mcguzxqemRbGclPBsl+Xli//FAciQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199018)(6512007)(7116003)(31686004)(38100700002)(2906002)(316002)(8936002)(186003)(6506007)(110136005)(5660300002)(122000001)(82960400001)(31696002)(86362001)(2616005)(91956017)(66476007)(478600001)(558084003)(76116006)(36756003)(66946007)(4326008)(71200400001)(38070700005)(6486002)(3480700007)(66446008)(66556008)(8676002)(64756008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHE4cmJGbitsVlE2UGFBUWIvQXJiUlp5bFJ1MU13WUl5WFN5NythNHlUZHNX?=
 =?utf-8?B?V0haU015MGJ5YU1SZHg0Nm1sUnlRNEtEZjZabEswMHhJcTJlY0E1RzhoT3VW?=
 =?utf-8?B?bnBiTXFSL3ROZHlVN3VtdzlvdFBBckZFWGhubWxxcXNPUEhTYTBHRnNEL2sw?=
 =?utf-8?B?eEQ3cDZGdzN3ekZWdWYxZDZuQ29xZzJNMndFaHVUVWdFWW9BZWZzSm1USTdX?=
 =?utf-8?B?cVM0Z1BqUHNVUlMxOHh5RXArQUFmVk4yZzRrL0hhd1ZDOUpHQ3VNME43UVIz?=
 =?utf-8?B?bjJKVnNsNlNzNmdYMEFWSTVaUmFjcUo3K05zaEV4bXVKcVpCU0lNQ0xTdUFp?=
 =?utf-8?B?N0QwMFVOTEtPMTBDRmxVTk5tTkdmUWZzdHB3Z2wxMGZ1UkRDVlJXR0pPUUFS?=
 =?utf-8?B?clFhZUlxR0U4d3hvQmpBcVJvYWdXdko2K3hzZ3g2QlNzYWZDdUVyelJYOGMy?=
 =?utf-8?B?OERUZE5ibElUeU5OSDhXSHkvTWVFbk1OUmJwU3MzZlJ1YTA5QzMyZ1FFakIz?=
 =?utf-8?B?VUZhdWZhaVRCSHJDR0lRT2NEbWlQWlFEcGNHMlVHOEJyOTZxOEd4dGpmZWVL?=
 =?utf-8?B?MlBLWVlXdFFiZlBiUG0ram5vOEM0bEpIb0Y0N0oySmFEZDNpZHZ2bUZGTCtu?=
 =?utf-8?B?WHhyOGVXNzFUaFdudE9VVEdmbWtaY3l6Q3Q3SDI5VmtOVWZIdi9HblZZZXpK?=
 =?utf-8?B?ak1kTkF3b1Y0SlRGMnIvTkUzWGFxVURNQ2pIRjhJUTlQUkpzcXR2RDJLNGU4?=
 =?utf-8?B?UVZRc0NNeVhwbEFPY1ZKM081SkFtYlRpU2ZFU3JEZWlLbGhudENBb016aDM3?=
 =?utf-8?B?em04VG9Sa2VNSDBrZndDZVFvcEVlN2hFd2FSUFB0alM0a3FqTDRreHlvV1ZC?=
 =?utf-8?B?SjBpQnMvVGJRNnpHdEc2Y001NElVOEQ2elNuQkhFcExHWVRvY1ozRjRHTC80?=
 =?utf-8?B?K0JsODlkdUgwSHdXSktwUFJNd2tmYnhPMm01KzRVWEowbElUd081TDFsbktM?=
 =?utf-8?B?STVQOElzdklDdmhFc0YyTmlYcERsL1ZDYm9zMTNjbmJ6c2l5bk1RUzRyc1Rh?=
 =?utf-8?B?L2tnd2ZKNC9tMThzaGxwTjlLeVhHODJldXJoVVE2UWtzcmJqSXl2YUtmZnhV?=
 =?utf-8?B?V0hyNGJFcTQyc2RUTzBnTnU2WlUxSXNjM2l6cjNaS2YwZ1JGeUg2ekxMczN0?=
 =?utf-8?B?bjdmeWxYMmdYd1VqZkdrWVorWjd2YzRjc2QydkorKzVtWVlDRGppeFJhZEth?=
 =?utf-8?B?QUkzU2RUUDhPOUV5VU1ucWsvTXlKWEJpR2F2cHc5WHpyT2JFeTMrbTIvQy9F?=
 =?utf-8?B?OVJvdlcrZ1E0a3J5Y2NnT3hwVEhudE5ZMkZreFphN3BYU2l2VTJ3MWZHc09a?=
 =?utf-8?B?SlNZemJrMzZ0cUh0R29VYnQ3QlNGZFNuZE9YcnZnaDEzby90ejJ3cFZqdVI5?=
 =?utf-8?B?UGpwVlJQcUpQeUpoZzFBRGtBSUE0SVlBMGpycDBwdnhtUHd0VitmR25mL1BP?=
 =?utf-8?B?STZEajhiV0xmbm81bmhmRVVtZDlQUkNVYkJNS0IyVHVub2pkdCtiN2Z5Vy81?=
 =?utf-8?B?cW1qZXJaUS8xRkVTTzZCODhoQWZsclZVdlpyclR4M1FTcWk3WGlJekJmOEN3?=
 =?utf-8?B?RURDQnZJSDRxa1N2STl1TlFpMmRuUTVCOVF0U3dYVi9iUUx5bCswY0dETTBF?=
 =?utf-8?B?R0l0dHBLRXBvR1gzMFpIVTJremt5SlFMRml3RlFNYkVpSjZ1blY5LzJpZ0JE?=
 =?utf-8?B?VGg2citBRzVMZDRjbStlVDZJWHlUN01OUFZDOVZXT0lpNHFvYm5hMnpzQUNE?=
 =?utf-8?B?aEU1ZjM2UW5ISy9Bd1RoS0hUdzBSUFI4ZG9ob0VJNkVUTzVuVkRrZ3ZjM0N6?=
 =?utf-8?B?OVRVSVN6TTJMU014K3FTOTB0Zk5yczJ2QXlGQ0RwNEZkUXM1N1IxQXZ6SThT?=
 =?utf-8?B?MnJOL3pDQ1Z5R0M5WjkwSU9HTGwzaEhRK3pxeDYzRHRVYXUyTkEzS1VkeTFL?=
 =?utf-8?B?bDNyeHVpSzlnSmtNRXllc1lYanEzRWVmM2kzbTdTR3d2d1Z5WXVjR2llSUNo?=
 =?utf-8?B?WVF3SGdubm1HbWpHbnFzQzlwdjhIRjF1STZibGordmt4cmxnV0l4SnZIWUZW?=
 =?utf-8?B?RnE0Y2kzU0xBTmdKNE1icHk0d2QydldLUEp2ZFVxd3FwWTR0TnQ1azRhMTdV?=
 =?utf-8?B?Y05HdDI1ekdqU3hyWTZLMzZGNCtxMzRUbUZCTGZ0OENEUHhJUDlmdkltamxw?=
 =?utf-8?Q?TPlnfF8KG9ed6z6Pcb/xfx+5Cusq13EzjVKD7mBDao=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77C558967A152D4F8DC37983A06F2CC6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qDR9UIGNCwUP+VRnxOXBgzm0azVqD1n5RgMxMBRxeLg26eFKBtwoyJOiKHxkYNVQcVVbNxKX9gj013li/W++ilfkxxt14pDUKjP4MvzNCmXiEFCtuz2HW1GDJRMR+U9Ip+c7aOySQ85v7aWr8Bix41tj3hKeSv2bo85WWSK1VJqo+aONiCp08JD1Oj70Dgq5CEfdrO0LnHQHzK5MgwFF9KvodfpHVAquQ1npQ0p+wPz+/inslcI3rcLF85TROqTqzvAyiQVG7GYfDuvN4SkcHK7oglQ9bZQMB606ajDCsfyrdAhh/hRueJxMh0zgOVd6P0K6raNmFK5zXv+WJY+7QkaR4JpcAMA3waNqQa4QVmhYLt9fA+eInx4NTUo9LT1SmGtOCp6R9+vIiW1KnOeAftI4imsroH/qIQuRXs8r/cvvBaLd8Cz62q1h3yYUdZz9xrvsgMh4GEmZg64i3vACf9jQQwlSsZM9hDpq3xqtDIASr25sio1tUNdmI+X08rzwKxQWbE/OW/bDk2/JWbI4TlhiTqjAB09zmGcEBTVkmZXtiruX2k3evm/T/T3qLwyNL6lDgXSX/b8z54TwlMU+71OJqZlZ9cfc5gAlhrrCNj9AL08mrY748WMpGslZ1lvK/pLXwxKvk6hD1lchOuUgxAUBDHdkqLGjPT4zdZgTj2vKKQ1uSsjsMFI8sKtnPyRnlSKOQFd9NTHvh78Vpcirrw4Q/9jDpJIpNa6cpbMvOSHz3Aw+SjhzjFn0dP5rRmIDH9WkOc/ghrmLlXg+iMPKSNNdbNkYI6XHIL6b51vnoBzhVojhkXgaiwnYBjxS8mRgvpygmMMDLpo0B8oeFckAE/paqP5wgDztRtCwGsJW1beYBk9JqWAZgt+x1HIQ1Qoh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1f595f-5f0f-428d-387d-08db0b5760fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 11:10:11.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZJHpG89y/5po68JYPHyrcFtQ1gyCm/yk6vFnQNFTczkGbCp+fpu92hdBaTRuHNg/mybucO+RoszvDViDQmuzlJ0iFDbNCj2dnkzEuiRbMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6121
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

QXBhcnQgZnJvbSB0aGUgdHdvIHR5cG9zIGluIDEvOCBsb29rcyBnb29kLA0KUmV2aWV3ZWQtYnk6
IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=
