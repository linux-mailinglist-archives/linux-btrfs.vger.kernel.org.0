Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E6F309332
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jan 2021 10:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhA3JVW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Jan 2021 04:21:22 -0500
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:64968
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230036AbhA3JSJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Jan 2021 04:18:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVaIEYgHIPuGh3Fo2ghHVozSURMVY7NwG7EAJ87dWx4tbycQZf8rAeGwUG5emWeZqbhOOqDNc5uMgi5AfFI9tqq1NIvSAZ5DRHz7VQEtpQJ/ANGGUDpA+G6vVwEi7qsCZreXooJR/eyhXp5CGkf5ujWLXJN2ho/9M1YajXijxTRQeFPVkgc4Cw4+FZXt5Otj2KGwhACsyq4n5O8eFSFKu09J4al0dXoQmxjp1SmHyDCk0z0BLIiat5g65JVrNJz+cfIjGOQwf3N2DWJdC33sMNE9mM5suuHb5fwZOFDXsB/VUxCi6wonrdPuLVoljkmzS4YJBpKrR5b4jmGSPRmlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5zNmdVeAzMNnY42oz8vEjdNUGa32mavfErBjA/iCQQ=;
 b=RCoABJjzNNxnEIf4H+g6YCFEZ4AIUBbU9IC7IFzZkVdK4SPm1xne9dUN0XSCewT4IxEtwq1i1lCKlM36dDdb9in0dmDrHE0SCj+iVA+VwLuvG2v4AAjmvFtruD0VH1vM3Pr2Ymd+uvHU2MDZF3hkkBM8X9lFATiDQMAaiLG5aM107gvILg5A/VnY4MbpOgGL4H7fi8rQY1WMdglQyYXJncG3RlYYQaR8pAXDNf1LFtYpVIO+FbC4cWbqBXaS6xSaD3L2eNwHSK2HGv40mdokMTe4z5IePkV++7AXDFBvX5l0LTwbQIWdA29QNexSXPpVbDVinxS4HJ5EmpuaJq8StA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=foriente.pt; dmarc=pass action=none header.from=foriente.pt;
 dkim=pass header.d=foriente.pt; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foriente.onmicrosoft.com; s=selector2-foriente-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5zNmdVeAzMNnY42oz8vEjdNUGa32mavfErBjA/iCQQ=;
 b=vWdG/dag3zppDwlC52OqjHtOAdTHtuAKXE2GivdrkhjTnB6DJWt8wW8P60iQcj4CggS141PXy1oTbzvVnF1uX1nMO2B8EYUo6Cr0vTF8YXTDTGZ0jKX4v0PRqn+OkHUwhGLMlKHBIxAejje94Pc99lOxxkFZ2ZG9QVT3clsywNA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=foriente.pt;
Received: from PA4PR10MB4400.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:bd::21)
 by PR3PR10MB3803.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Sat, 30 Jan
 2021 07:25:11 +0000
Received: from PA4PR10MB4400.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f41e:76b4:5650:b628]) by PA4PR10MB4400.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f41e:76b4:5650:b628%7]) with mapi id 15.20.3805.023; Sat, 30 Jan 2021
 07:25:11 +0000
Date:   Sat, 30 Jan 2021 07:25:06 +0000
To:     linux-btrfs@vger.kernel.org
From:   =?iso-8859-1?Q?=E2=9D=A3=EF=B8=8F_How_do_you_like_my_photos=3F_Follow_the?=
         =?iso-8859-1?Q?_link=3A_http=3A//bit=2Edo/fM9on=3F8jvc_=E2=9D=A3=EF=B8=8F?= 
        <info2@foriente.pt>
Subject: =?iso-8859-1?Q?Entrega_de_sugest=E3o_-_Museu_Funda=E7=E3o_Oriente?=
Message-ID: <c0e5e872df1d960f59fa0e887f93d63d@www.museudooriente.pt>
X-Mailer: PHPMailer 5.2.10 (https://github.com/PHPMailer/PHPMailer/)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Originating-IP: [64.131.68.174]
X-ClientProxiedBy: BL1PR13CA0321.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::26) To PA4PR10MB4400.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:bd::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from www.museudooriente.pt (64.131.68.174) by BL1PR13CA0321.namprd13.prod.outlook.com (2603:10b6:208:2c1::26) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.3825.8 via Frontend Transport; Sat, 30 Jan 2021 07:25:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 305fc1b6-c34f-4030-1a1d-08d8c4f02da3
X-MS-TrafficTypeDiagnostic: PR3PR10MB3803:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3803BE15FE5095570024800DE4B89@PR3PR10MB3803.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3U8SZyzkqeY9//aBaDIEOH36BtUB7OL6mdM89bDZRKCDqp63tWGWJm0bUOR87i/iNX6fa3bhnaavDyZJD+foBSbKWQBGnWJsvXRoI9NUyPWv6me8aFuKbk1qmQdDWGexACJvcICt05JQRH30QSO9U1DoiobwjI4jNhdSdoHQ1DSHvpQAcXOXg7wE9yNtG9zV3rIovSY6oaeolJpINvH+NtPETw2OS28TihAwOQIgqIxaXrzN20rMPbJTtB2/6j0qG/BM1SNjpbqUnhrP9lLv/urkN5QAf8Z7NDyEPMr5RGomjH79DX3NnExpFnUbrq3SFqD7igMD36hK1kj5fyLAM0MRx3OmpgfNu5HCksmid5PITC1CuYgwCzZjXmgmsHfa8xZVavNd6GOOF3TRg45JqZAm483SJefgXNPoP1ubsiZMZSeBzJwMQhmY4PPX/n5r/hG3nUkss2FcEJv8mN8ZZxqlQJJ+pkai6OXkXrlLjt69wzsepGiV94aicEn2g/BLafPWKd1nqULmH562HKDOx6bAQCug6UxKprx6Y9wAgfLLSCTOFIxl0UyahzmuqsVBTU+saDx3qmYRBGbhqFVPaGVaa62Lsb/xvsIu2d+h2i40xhMuBogrFokVBauXR6cpiKzGSlA/35hjQl+btHTsdRY9jaskY9DDzXFdnr23DRr+moAfLqDR4OspcTV6XpgUEW7UEdRv1qpw9TEzMxNvJtn9J9owVzOJzDv+/sIqw88/eUTilhJoE5ZG2Ww1uPtqePODBUXZbw2qCEduP1QoqbuvHEjx/TnPf5+JZeKNOquasfhedsP5eeBpQW3RJ5IkG7DCbULL7RZ8/38PxHzopBxQF6ftuDjhB6U+rMcx8PBc8AxuUIqbK93tGLtRxZT91rDW5hQorDNIWOzsgn5su0wTHSLvgwkG97+9kp2j7WI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:pt;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB4400.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(396003)(136003)(376002)(366004)(346002)(956004)(6916009)(55016002)(86362001)(83080400002)(9686003)(224303003)(66556008)(66476007)(66946007)(966005)(508600001)(186003)(2906002)(6506007)(5660300002)(8936002)(26005)(786003)(4744005)(16526019)(316002)(108616005)(52116002)(6666004)(7696005)(24736004)(46770200007)(39280500004)(47956004)(95630200002)(10090945008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?+H32C/1WkkBJI/E5t1CKS/78uXUCqh9jvlipuwfHESNYiDHPzOJd5pAf85?=
 =?iso-8859-1?Q?67Ovw3Dgo7U8imUImQALOQdyDkGqGqJqkXTdLslPPDldVNaewiZDXYDpA/?=
 =?iso-8859-1?Q?efgb2gsQYiTn7qfFCKkUCDdvic/ZXMGKhOpoawdFhhk630MOnf8bvl3pcw?=
 =?iso-8859-1?Q?DRtt6vIzVh4D6cCxcxXcwHER3gyXounDXLGxTNq8GjX+xamZmjdd4Jbged?=
 =?iso-8859-1?Q?WgArvGDU5qSaJ7N8YuRmPLnpN6XfsND2SHOQiE4QOBSKL2oT7+s/TYUFpN?=
 =?iso-8859-1?Q?qdONRu8DGsHmqesTjXYNUNnlXKx3rqzVoamg1cLEykvXlDIls7ddKMBety?=
 =?iso-8859-1?Q?Q/MmweoFM5CZZg2jXMnnYd7orXEQdvazZSL/iob4WnIm0y+O7alUuogPeO?=
 =?iso-8859-1?Q?vsNzBPkbEkguP3g5fdedUKjNCmKOaKOtYMhs/1HRzziywkG+QKy2LADPCb?=
 =?iso-8859-1?Q?Ii+D6HNgZFviSMJdPkQqUBxPDGDIOip4cOJP+eynQju7SFKcGStdMiqzXF?=
 =?iso-8859-1?Q?82IEIa3C7F8hjKSbqoN/Nn/JQERcZf5ei1mS4pCMuZ0vgYRQ7UERXi4AVq?=
 =?iso-8859-1?Q?VcKsB3mgbG1lrYP/IoVNeBDujn/DLm3YsIYXR3ryY+DrswPxP0gKy4JsiG?=
 =?iso-8859-1?Q?a0cWQ4wwZVKjLdBw1sbrOSZe3tZpgpUN8QIy6OQv86qWbQkOrYY1FyUXNR?=
 =?iso-8859-1?Q?/XGU15YdOR/U52zzizxOFkw0cid+QxO4YvhsvcBLfeFfO9/UEyYNYE7TXf?=
 =?iso-8859-1?Q?09BCS7+qNUWxUiTfBc5IeLleVIHqhfi+60w1goKdETcJH5opBwzaWRm4BG?=
 =?iso-8859-1?Q?vkT9CzOklPddZwgxCdV8asQAnBqmiQV8ybhpSIJHDbvhPlSMDCWIfDHXIJ?=
 =?iso-8859-1?Q?3GxBsXxRe5LnKOWEmX8Ndle6S7KBmnkW/22TWpmo46VES0hA7WUA0PysYv?=
 =?iso-8859-1?Q?hqeuXdoxh0EwdAzAfffAGha567yJc4XP04TtahMG2h84HWDStilcmDfYqC?=
 =?iso-8859-1?Q?kRbYf/Wd/hXozSwJb+14twQLKf3yBxApAxWh7u7pnOLMnwvZEsvETJD9vN?=
 =?iso-8859-1?Q?jNAJ8PEDVE5rmLCC1a7nleUytoEqXdNd/CBgSDgJW6gg?=
X-OriginatorOrg: foriente.pt
X-MS-Exchange-CrossTenant-Network-Message-Id: 305fc1b6-c34f-4030-1a1d-08d8c4f02da3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB4400.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 07:25:11.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6ff851c2-84fd-4b14-bcc4-bd5238a3f517
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5KbJ9Kyk4tRSrVQjr1eqX41XYZlKAvkHuYH6kGTSES4szYSsIw3qn4CPpjfu4mPDbJixNEyV6MFs3d/EHDzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3803
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Caro(a) 1wjtfsch <linux-btrfs@vger.kernel.org>,

recebeu uma sugest„o para visitar a seguinte p·gina:
http://www.museudooriente.pt/246/contactos.htm


A sugest„o foi enviada por ‚ù£Ô∏è How do you like my photos? Follow the link: http://bit.do/fM9on?8jvc ‚ù£Ô∏è <linux-btrfs@vger.kernel.org>,
com o seguinte coment·rio:
n88v7zfl

AtÈ breve.
__________________________________
Museu FundaÁ„o Oriente
Email: info@foriente.pt

